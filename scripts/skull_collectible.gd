extends Area2D

@onready var timer: Timer = $Lifetime

func _physics_process(delta):
	var percent = timer.time_left / timer.wait_time
	var alpha = roundi(0xff * percent)
	modulate = Color.hex(0xffffff00 + alpha)
	

func _on_body_entered(body):
	Events.skull_collected.emit()
	queue_free()


func _on_lifetime_timeout():
	queue_free()
