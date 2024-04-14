extends CharacterBody2D

class_name Demon

var master
var speed = 450
var min_distance = 30
var level = 0

@onready var sprite = $Sprite2D

func _physics_process(delta):
	if master != null and global_position.distance_to(master.global_position) >= min_distance:
		var direction = global_position.direction_to(master.global_position)
		velocity = direction * speed
		move_and_slide()

func level_up():
	level += 1
	if level <= 5:
		sprite.frame = level - 1
	match level:
		1:
			Events.LEVEL_FIRST.emit()
		2:
			Events.LEVEL_SECOND.emit()
			#var tween = create_tween()
			#tween.tween_property(sprite, "scale", Vector2(20, 20), 5)
		3:
			Events.LEVEL_THIRD.emit()
		4:
			Events.LEVEL_FOURTH.emit()
		5:
			Events.LEVEL_FIFTH.emit()
			
	scale += Vector2(0.2, 0.2)
