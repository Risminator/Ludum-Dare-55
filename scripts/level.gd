extends Node

@onready var player = $Player
@onready var parallax = $ParallaxBackground
@onready var cameraRemote = $Player/RemoteTransform2D

const WOLF = preload("res://scenes/enemies/wolf.tscn")	
const CRUSADER = preload("res://scenes/enemies/crusader.tscn")
const SKULL = preload("res://scenes/skull_collectible.tscn")

var MOBS = [
	WOLF
]

var need_skulls = false
var can_spawn = false

func _ready():
	Events.connect("start_game", _on_Events_start_game)
	Events.connect("skulls_lost", _on_Events_skulls_lost)
	Events.connect("skull_collected", _on_Events_skull_collected)
	Events.connect("LEVEL_FIRST", _on_Events_LEVEL_FIRST)

func spawn_enemy():
	print(MOBS.size())
	var new_enemy = MOBS.pick_random().instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	new_enemy.player = player
	add_child(new_enemy)
	
	if need_skulls == true:
		var chance = randf()
		if chance < 0.5:
			var new_skull = SKULL.instantiate()
			%PathFollow2D.progress_ratio = randf()
			new_skull.global_position = %PathFollow2D.global_position
			add_child(new_skull)

var direction = Vector2(0, 1)

func _process(delta):
	#var direction = player.velocity
	if player != null:
		parallax.scroll_offset += direction * player.speed * delta

func _on_timer_timeout():
	if can_spawn and player != null:
		spawn_enemy()

func _on_Events_start_game():
	can_spawn = true
	cameraRemote.update_position = true

func _on_Events_skulls_lost():
	need_skulls = true

func _on_Events_skull_collected():
	need_skulls = false
	
func _on_Events_LEVEL_FIRST():
	print("AAAAAAAA")
	MOBS.append(CRUSADER)
