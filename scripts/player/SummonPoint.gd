extends Marker2D

@export var summon_position = 0
@export var rotation_rate = 0.03
@export var distance = 100
var is_free = true

var point = Vector2(0, 0)

func _on_events_LEVEL_FIRST():
	rotation_rate += 0.03
	print("FASTER!")

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("LEVEL_FIRST", _on_events_LEVEL_FIRST)
	var initial_angle = summon_position * deg_to_rad(72)
	position = point + Vector2(cos(initial_angle), sin(initial_angle)) * distance


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#ar point = Vector2(100, 0)
	position = point + (position - point).rotated(rotation_rate)
