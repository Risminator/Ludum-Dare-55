extends Node2D


func _on_life_timer_timeout():
	queue_free()
