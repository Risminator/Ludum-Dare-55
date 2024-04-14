extends Marker2D

signal ritual_ready

@onready var summon_points = get_children()
var familiars = 0

func add_familiar():
	if familiars == 5:
		ritual_ready.emit()
	else:
		for slot: Marker2D in summon_points:
			if slot.is_free:
				slot.is_free = false
				familiars += 1
				const FAMILIAR = preload("res://scenes/player/familiar.tscn")
				var new_familiar = FAMILIAR.instantiate()
				slot.add_child(new_familiar)
				break
		print(familiars)

func lose_familiar(familiar):
	var slot = familiar.get_parent()
	slot.remove_child(familiar)
	familiar.queue_free()
	slot.is_free = true
	familiars -= 1
		
func clear_familiars():
	for slot: Marker2D in summon_points:
		for n in slot.get_children():
			slot.remove_child(n)
			n.queue_free()
		slot.is_free = true
	familiars = 0
		

func _ready():
	Events.connect("skull_collected", _on_Events_skull_collected)
	Events.connect("familiar_lost", _on_Events_familiar_lost)
	
func _on_Events_skull_collected():
	call_deferred("add_familiar")

func _on_Events_familiar_lost(familiar):
	call_deferred("lose_familiar", familiar)
