extends Marker2D

@onready var summon_points = get_children()

func add_familiar():
	if Global.familiars == 5:
		Events.ritual_ready.emit()
	else:
		for slot: Marker2D in summon_points:
			if slot.is_free:
				slot.is_free = false
				Global.familiars += 1
				const FAMILIAR = preload("res://scenes/player/familiar.tscn")
				var new_familiar = FAMILIAR.instantiate()
				slot.add_child(new_familiar)
				break

func lose_familiar(familiar):
	var slot = familiar.get_parent()
	if slot != null:
		slot.remove_child(familiar)
		familiar.queue_free()
		slot.is_free = true
		Global.familiars -= 1
		if Global.familiars == 0:
			Events.skulls_lost.emit()
		
func clear_familiars():
	for slot: Marker2D in summon_points:
		for n in slot.get_children():
			slot.remove_child(n)
			n.queue_free()
		slot.is_free = true
	Global.familiars = 0
		

func _ready():
	Events.connect("skull_collected", _on_Events_skull_collected)
	Events.connect("familiar_lost", _on_Events_familiar_lost)
	
func _on_Events_skull_collected():
	call_deferred("add_familiar")

func _on_Events_familiar_lost(familiar):
	call_deferred("lose_familiar", familiar)
