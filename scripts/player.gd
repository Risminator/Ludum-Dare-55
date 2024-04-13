extends CharacterBody2D

@export var speed = 200
@export var norm = 4
var mouse_pos = null
var demon = null

func level_up():
	if demon != null:
		demon.level_up()
	else:
		const DEMON = preload("res://scenes/player/demon.tscn")
		var new_demon = DEMON.instantiate()
		new_demon.master = self
		print(new_demon.name)
		add_child(new_demon)
		demon = new_demon
	var tween = create_tween()
	tween.tween_property(%Circle, "modulate", Color.hex(0xffffff00), 1)

func _physics_process(delta):
	velocity = Vector2(0,0)
	mouse_pos = get_global_mouse_position()
	if abs(mouse_pos - position) > Vector2(norm,norm):
		var direction = (mouse_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()
		
	var overlapping_hazards = %HurtBox.get_overlapping_bodies()
	if overlapping_hazards.size() > 0:
		queue_free()


func _on_summons_ritual_ready():
	%Summons.clear_familiars()
	%Summons.add_familiar()
	var tween = create_tween()
	tween.tween_property(%Circle, "modulate", Color.hex(0xffffffff), 1)
	level_up()
