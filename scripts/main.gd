extends Node


func start_game():
	Global.set_scene(Global.SCENES.LEVEL)


func quit_game():
	get_tree().quit()


func _on_btn_start_pressed():
	call_deferred("start_game")


func _on_btn_options_pressed():
	pass


func _on_btn_exit_pressed():
	call_deferred("quit_game")
