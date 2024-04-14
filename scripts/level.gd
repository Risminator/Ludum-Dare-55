extends Node

@onready var player = $Player
@onready var parallax = $ParallaxBackground

const WOLF = preload("res://scenes/enemies/wolf.tscn")	
const CRUSADER = preload("res://scenes/enemies/crusader.tscn")

const MOBS = [
	WOLF,
	CRUSADER
]

func spawn_enemy():
	var new_enemy = CRUSADER.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	new_enemy.player = player
	add_child(new_enemy)

var direction = Vector2(0, 1)

func _process(delta):
	#var direction = player.velocity
	if player != null:
		parallax.scroll_offset += direction * player.speed * delta

func _on_timer_timeout():
	if player != null:
		spawn_enemy()
