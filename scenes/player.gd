extends CharacterBody2D

@export var speed = 200
@export var norm = 5
var mouse_pos = null


func _physics_process(delta):
	velocity = Vector2(0,0)
	mouse_pos = get_global_mouse_position()
	if abs(mouse_pos - position) > Vector2(norm,norm):
		var direction = (mouse_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()
