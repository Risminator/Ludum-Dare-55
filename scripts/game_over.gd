extends Control

func _on_btn_play_pressed():
	Global.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_btn_quit_pressed():
	get_tree().quit()
