extends Area2D

@onready var summon_point = get_parent()

func die():
	Events.familiar_lost.emit(self)

func _physics_process(delta):
	var overlapping_hazards = self.get_overlapping_areas()
	for body in overlapping_hazards:
		if body.has_node("enemy_weapon"):
			die()


#			slot.remove_child(n)
#			n.queue_free()
#		slot.is_free = true
#	familiars = 0
