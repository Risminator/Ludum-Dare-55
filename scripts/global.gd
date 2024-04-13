extends Node

const SCENES = {
	MAIN = "menus/main",
	OPTIONS = "menus/options",
	ENDING = "menus/ending",
	LOST = "menus/lost",
	LEVEL = "levels/level"
}

func set_scene(scene_name: String):
	get_tree().change_scene_to_file("res://scenes/" + scene_name + ".tscn")
