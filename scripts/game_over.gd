extends Control

func _on_btn_play_pressed():
	Global.reset()
	get_tree().paused = false
	Global.set_scene(Global.SCENES.LEVEL)


func _on_btn_quit_pressed():
	get_tree().quit()
