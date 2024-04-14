extends CharacterBody2D

@export var speed = 200
@export var norm = 4
var mouse_pos = null
var demon = null


func level_up():
	if demon == null:
		const DEMON = preload("res://scenes/player/demon.tscn")
		var new_demon = DEMON.instantiate()
		new_demon.master = self
		new_demon.global_position = global_position
		print(new_demon.name)
		add_child(new_demon)
		demon = new_demon
	demon.level_up()
	var tween = create_tween()
	tween.tween_property(%Circle, "modulate", Color.hex(0xffffff00), 1)

func _physics_process(delta):
	velocity = Vector2(0,0)
	mouse_pos = get_global_mouse_position()
	
	
	if abs(mouse_pos - position) > Vector2(norm,norm):
		var direction = (mouse_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()
	
	var overlapping_hazards = %HurtBox.get_overlapping_areas()
	if overlapping_hazards.size() > 0:
		queue_free()


func _on_summons_ritual_ready():
	%Summons.clear_familiars()
	%Summons.add_familiar()
	var tween = create_tween()
	tween.tween_property(%Circle, "modulate", Color.hex(0xffffffff), 1)
	tween.tween_callback(level_up)
