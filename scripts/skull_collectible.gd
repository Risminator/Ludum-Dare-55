extends Area2D

func _on_body_entered(body):
	Events.skull_collected.emit()
	queue_free()
