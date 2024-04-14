extends CharacterBody2D

var player = null
@export var speed = 200

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var attack_center: Area2D = $AttackCenter
@onready var attack_hitbox: CollisionPolygon2D = $AttackCenter/CollisionPolygon2D

var direction
var can_drop_skulls = true

@export var dashing = false

func _ready():
	Events.connect("LEVEL_FIRST", _on_Events_LEVEL_FIRST)
	$AttackTimer.start()

func lock_on():
	if player != null:
		attack_center.look_at(player.position)
		direction = global_position.direction_to(player.global_position)
	else:
		direction = Vector2(0, 0)

func attack():
	animation.stop()
	animation.play("swipe")
	#attack_center.look_at(player.position)
	#attack_center.visible = true
	#attack_hitbox.disabled = false
	#dashing = true
	

func die():
	queue_free()
	Events.enemy_killed.emit()
	if Global.can_spawn_skull() and can_drop_skulls:
		const SKULL = preload("res://scenes/skull_collectible.tscn")
		var new_skull = SKULL.instantiate()
		new_skull.global_position = global_position
		get_parent().add_child(new_skull)

		
func _physics_process(delta):
	if player != null:
		if player.global_position.x >= global_position.x:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
			
		if !dashing:
			direction = global_position.direction_to(player.global_position)
		if speed > 0:
			velocity = direction * speed
			move_and_slide()
		
	var overlapping_hazards = %HurtBox.get_overlapping_areas()
	for body in overlapping_hazards:
		if body.has_node("player_weapon"):
			die()


func _on_timer_timeout():
	if player != null:
		attack()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "swipe":
		$AttackTimer.start()
		animation.play("idle")
	#	attack_center.visible = false
	#	attack_hitbox.disabled = true
	
func _on_Events_LEVEL_FIRST():
	can_drop_skulls = false
