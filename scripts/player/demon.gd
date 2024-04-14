extends CharacterBody2D

class_name Demon

var master
var speed = 300
var min_distance = 30

func _physics_process(delta):
	if master != null and global_position.distance_to(master.global_position) >= min_distance:
		var direction = global_position.direction_to(master.global_position)
		velocity = direction * speed
		move_and_slide()

func level_up():
	scale += Vector2(0.1, 0.1)
	print("Я вырос!")
