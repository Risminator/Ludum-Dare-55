extends Node

@onready var player = $Player
@onready var parallax = $ParallaxBackground
@onready var cameraRemote = $Player/RemoteTransform2D
@onready var game_over_menu = $CanvasLayer
@onready var dash_tip = $CanvasLayer2/PanelContainer/VBoxContainer/DashTip
@onready var rotate_tip = $CanvasLayer2/PanelContainer/VBoxContainer/RotateTip
@onready var speed_tip = $CanvasLayer2/PanelContainer/VBoxContainer/SpeedLabel
@onready var radius_tip = $CanvasLayer2/PanelContainer/VBoxContainer/RadiusLabel
@onready var unkillable_tip = $CanvasLayer2/PanelContainer/VBoxContainer/UnkillableTip

@onready var music1 = $Player/AudioStreamPlayer2D2
@onready var music2 = $Player/AudioStreamPlayer2D3

var scroll_direction = Vector2(0, 1)

const WOLF = preload("res://scenes/enemies/wolf.tscn")	
const CRUSADER = preload("res://scenes/enemies/crusader.tscn")
const SKULL = preload("res://scenes/skull_collectible.tscn")

var max_mobs = 3

var spawned_mobs = 0

var MOBS = [
	WOLF
]

var need_skulls = false
var can_spawn = false


func _ready():
	Events.connect("start_game", _on_Events_start_game)
	Events.connect("game_over", _on_Events_game_over)
	
	Events.connect("skulls_lost", _on_Events_skulls_lost)
	Events.connect("skull_collected", _on_Events_skull_collected)
	Events.connect("enemy_killed", _on_Events_enemy_killed)
	
	Events.connect("LEVEL_FIRST", _on_Events_LEVEL_FIRST)
	Events.connect("LEVEL_SECOND", _on_Events_LEVEL_SECOND)
	Events.connect("LEVEL_THIRD", _on_Events_LEVEL_THIRD)
	Events.connect("LEVEL_FOURTH", _on_Events_LEVEL_FOURTH)
	Events.connect("LEVEL_FIFTH", _on_Events_LEVEL_FIFTH)

func spawn_enemy():
	var new_enemy = MOBS.pick_random().instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	new_enemy.player = player
	spawned_mobs += 1
	add_child(new_enemy)

func spawn_skull():
	var chance = randf()
	if chance < 0.5:
		var new_skull = SKULL.instantiate()
		%PathFollow2D.progress_ratio = randf()
		new_skull.global_position = %PathFollow2D.global_position
		add_child(new_skull)


func _process(delta):
	#var scroll_direction = player.velocity
	if player != null:
		parallax.scroll_offset += scroll_direction * player.speed * delta

func _on_timer_timeout():
	if can_spawn and player != null and spawned_mobs <= max_mobs:
		spawn_enemy()
	if can_spawn and need_skulls == true:
		spawn_skull()

func _on_Events_start_game():
	can_spawn = true
	cameraRemote.update_position = true
	music1.playing = false
	music2.playing = true

func _on_Events_skulls_lost():
	need_skulls = true

func _on_Events_skull_collected():
	need_skulls = false
	
func _on_Events_LEVEL_FIRST():
	max_mobs = 8
	Global.skull_rate = 2
	speed_tip.visible = true

func _on_Events_LEVEL_SECOND():
	MOBS.append(CRUSADER)
	dash_tip.visible = true

func _on_Events_LEVEL_THIRD():
	MOBS.append(CRUSADER)
	MOBS.append(CRUSADER)
	Global.skull_rate = 3
	radius_tip.visible = true

func _on_Events_LEVEL_FOURTH():
	Global.skull_rate = 4
	rotate_tip.visible = true

func _on_Events_LEVEL_FIFTH():
	Global.skull_rate = 6
	max_mobs = 15
	unkillable_tip.visible = true
	
func _on_Events_game_over():
	can_spawn = false
	cameraRemote.update_position = false
	game_over_menu.visible = true
	get_tree().paused = true
	
func _on_Events_enemy_killed():
	spawned_mobs -= 1
