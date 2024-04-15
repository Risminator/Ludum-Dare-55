extends Area2D

@onready var summon_point = get_parent()
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var set_scale = Vector2(0.8, 0.8)

var can_be_ghost = false
var killable = true

func _ready():
	Events.connect("LEVEL_THIRD", _on_Events_LEVEL_THIRD)
	Events.connect("LEVEL_FIFTH", _on_Events_LEVEL_FIFTH)
	scale = set_scale
	animation_player.play("spawn")

func die():
	Events.familiar_lost.emit(self)

func _physics_process(delta):
	var overlapping_hazards = self.get_overlapping_areas()
	for body in overlapping_hazards:
		if body.has_node("enemy_weapon") and killable:
			die()

func _on_Events_LEVEL_THIRD():
	set_scale = Vector2(1, 1)

func _on_Events_LEVEL_FIFTH():
	killable = false
