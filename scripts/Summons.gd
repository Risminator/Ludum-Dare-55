extends Marker2D

@onready var summon_points = get_children()

func _ready():
	Events.connect("skull_collected", _on_Events_skull_collected)
	
func _on_Events_skull_collected():
	for slot: Marker2D in summon_points:
		if slot.is_free:
			slot.is_free = false
			const FAMILIAR = preload("res://scenes/familiar.tscn")
			var new_familiar = FAMILIAR.instantiate()
			slot.add_child(new_familiar)
			break
