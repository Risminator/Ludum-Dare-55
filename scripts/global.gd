extends Node

const SCENES = {
	MAIN = "menus/main",
	OPTIONS = "menus/options",
	ENDING = "menus/ending",
	LOST = "menus/lost",
	LEVEL = "levels/level"
}

var kills = 0
var skulls_collected = 0
var skull_rate = 3

func _ready():
	Events.connect("skull_collected", _on_Events_skull_collected)
	Events.connect("enemy_killed", _on_Events_enemy_killed)

func set_scene(scene_name: String):
	get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")

func _on_Events_skull_collected():
	if skulls_collected == 0:
		Events.start_game.emit()
	skulls_collected += 1

func _on_Events_enemy_killed():
	kills += 1
	
func can_spawn_skull():
	return kills % skull_rate == 0
