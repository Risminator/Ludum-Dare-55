extends CharacterBody2D

@export var speed = 325

var player = null

func die():
	queue_free()
	Events.enemy_killed.emit()
	if Global.can_spawn_skull():
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
		
	var overlapping_hazards = %HurtBox.get_overlapping_areas()
	for body in overlapping_hazards:
		if body.has_node("player_weapon"):
			die()
