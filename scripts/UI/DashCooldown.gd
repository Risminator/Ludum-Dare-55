extends ProgressBar

@onready var dash_cooldown: Timer = $/root/Level/Player/DashCooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dash_cooldown != null:
		value = (1 - dash_cooldown.time_left / dash_cooldown.wait_time) * 100
