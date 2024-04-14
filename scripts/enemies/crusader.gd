extends CharacterBody2D

var player = null
@export var speed = 200

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var attack_center: Area2D = $AttackCenter


func attack():
	animation.play("swipe")
	attack_center.look_at(player.position)
	attack_center.visible = true
	

func die():
	queue_free()
	Events.enemy_killed.emit()
	if Global.kills % 1 == 0:
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
			
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		
	var overlapping_hazards = %HurtBox.get_overlapping_bodies()
	for body in overlapping_hazards:
		if body.has_node("player_weapon"):
			die()


func _on_timer_timeout():
	if player != null:
		attack()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "swipe":
		attack_center.visible = false
