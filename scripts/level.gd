extends Node2D

@onready var player = $Player

func spawn_enemy():
	const WOLF = preload("res://scenes/enemies/wolf.tscn")
	var new_enemy = WOLF.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	new_enemy.player = player
	add_child(new_enemy)


func _on_timer_timeout():
	spawn_enemy()
