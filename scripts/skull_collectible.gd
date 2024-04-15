extends Area2D

@export var time_to_live = 5
@onready var timer: Timer = $Lifetime

func _ready():
	Events.connect("LEVEL_UP", _on_Events_LEVEL_UP)
	if time_to_live > 0:
		timer.wait_time = time_to_live
		timer.start()

func _physics_process(delta):
	if time_to_live > 0:
		var percent = timer.time_left / timer.wait_time
		var alpha = roundi(0xff * percent)
		modulate = Color.hex(0xffffff00 + alpha)
	

func _on_body_entered(body):
	Events.skull_collected.emit()
	queue_free()


func _on_lifetime_timeout():
	queue_free()

func _on_Events_LEVEL_UP():
	queue_free()
