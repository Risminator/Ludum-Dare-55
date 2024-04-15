extends CharacterBody2D

@export var speed = 300
@export var rotation_rate = 0.02
@export var norm = 4
var mouse_pos = null
var demon = null

var can_dash = false
var dash_speed = speed
var dashing = false

var can_rotate = false
var rotation_bonus = 0

@onready var dash_timer = $DashTimer
@onready var trail_timer = $TrailTimer
@onready var dash_cooldown_timer = $DashCooldown

@onready var rotate_timer = $RotateTimer
@onready var rotate_cooldown_timer = $RotateCooldown

@onready var animation = $Sprite2D/AnimationPlayer
@onready var particles = $Sprite2D/GPUParticles2D
@onready var summons = $Summons
@onready var circle = $Circle

@export var is_controllable = true

const TRAIL = preload("res://scenes/player/trail.tscn")

func level_up():
	if demon == null:
		const DEMON = preload("res://scenes/player/demon.tscn")
		var new_demon = DEMON.instantiate()
		new_demon.master = self
		new_demon.global_position = global_position
		add_child(new_demon)
		demon = new_demon
	demon.level_up()
	if demon.level == 1:
		rotation_rate += 0.03
	var tween = create_tween()	
	tween.tween_property(%Circle, "modulate", Color.hex(0x735c48ff), 1)
	tween.tween_property(%Circle, "modulate", Color.hex(0x735c4800), 1)

func _ready():
	Events.connect("ritual_ready", _on_Events_ritual_ready)
	Events.connect("LEVEL_FIRST", _on_Events_LEVEL_FIRST)
	Events.connect("LEVEL_SECOND", _on_Events_LEVEL_SECOND)
	Events.connect("LEVEL_THIRD", _on_Events_LEVEL_THIRD)
	Events.connect("LEVEL_FOURTH", _on_Events_LEVEL_FOURTH)
	Events.connect("LEVEL_FIFTH", _on_Events_LEVEL_FIFTH)

func _physics_process(delta):
	velocity = Vector2(0,0)
	
	if is_controllable:
		mouse_pos = get_global_mouse_position()
		
		if Input.is_action_just_pressed("Rotate") and can_rotate:
			rotation_bonus = 0.1
			rotate_timer.start()
			can_rotate = false
		
		%Circle.rotate(rotation_rate + rotation_bonus)
		
		if Input.is_action_just_pressed("Dash") and can_dash:
			dashing = true
			trail_timer.start()
			dash_timer.start()
			can_dash = false
		
		if abs(mouse_pos - position) > Vector2(norm,norm):
			var direction = (mouse_pos - position).normalized()
			if dashing:
				velocity = direction * dash_speed
			else:
				velocity = direction * speed
			move_and_slide()
		
		var overlapping_hazards = %HurtBox.get_overlapping_areas()
		if overlapping_hazards.size() > 0:
			is_controllable = false
			animation.play("death")


func _on_dash_timer_timeout():
	dashing = false
	particles.modulate = Color.hex(0xa2f300ff)
	trail_timer.stop()
	# reload
	particles.amount_ratio = 0.3
	dash_cooldown_timer.start()


func _on_dash_cooldown_timeout():
	particles.amount_ratio = 1
	particles.modulate = Color.hex(0xf20a27ff)
	can_dash = true


func _on_rotate_timer_timeout():
	rotation_bonus = 0
	rotate_cooldown_timer.start()
	

func _on_rotate_cooldown_timeout():
	can_rotate = true


func _on_Events_ritual_ready():
	%Summons.clear_familiars()
	%Summons.add_familiar()
	level_up()
	
func _on_Events_LEVEL_FIRST():
	rotation_rate += 0.01
	speed += 25

func _on_Events_LEVEL_SECOND():
	dash_speed = 600
	speed += 25
	can_dash = true
	particles.amount_ratio = 1
	particles.modulate = Color.hex(0xf20a27ff)

func _on_Events_LEVEL_THIRD():
	circle.scale = Vector2(1, 1)

func _on_Events_LEVEL_FOURTH():
	can_rotate = true

func _on_Events_LEVEL_FIFTH():
	pass


func _on_trail_timer_timeout():
	var new_shadow = TRAIL.instantiate()
	new_shadow.global_position = global_position
	add_child(new_shadow)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
		Events.game_over.emit()
