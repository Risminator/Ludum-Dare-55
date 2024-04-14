extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_play_pressed():
	Global.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_btn_quit_pressed():
	get_tree().quit()
