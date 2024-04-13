extends CharacterBody2D

@export var speed = 150

@onready var player = $/root/Level/Player

func die():
	queue_free()
	Events.enemy_killed.emit()
	print(Global.kills)
	if Global.kills % 5 == 0:
		const SKULL = preload("res://scenes/skull_collectible.tscn")
		var new_skull = SKULL.instantiate()
		new_skull.global_position = global_position
		get_parent().add_child(new_skull)

func _physics_process(delta):
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		
	var overlapping_hazards = %HurtBox.get_overlapping_bodies()
	for body in overlapping_hazards:
		if body.has_node("player_weapon"):
			die()
