extends HBoxContainer

@onready var akino_texture: TextureRect = $AkinoTexture
@onready var akino_label: Label = $AkinoLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("LEVEL_FIRST", _on_Events_LEVEL_FIRST)
	Events.connect("LEVEL_SECOND", _on_Events_LEVEL_SECOND)
	Events.connect("LEVEL_THIRD", _on_Events_LEVEL_THIRD)
	Events.connect("LEVEL_FOURTH", _on_Events_LEVEL_FOURTH)
	Events.connect("LEVEL_FIFTH", _on_Events_LEVEL_FIFTH)


func _on_Events_LEVEL_FIRST():
	akino_label.text = "1 / 5"
	akino_texture.texture.region.position = Vector2(0, 0)
	visible = true

func _on_Events_LEVEL_SECOND():
	akino_label.text = "2 / 5"
	akino_texture.texture.region.position = Vector2(63, 0)

func _on_Events_LEVEL_THIRD():
	akino_label.text = "3 / 5"
	akino_texture.texture.region.position = Vector2(63*2, 0)

func _on_Events_LEVEL_FOURTH():
	akino_label.text = "4 / 5"
	akino_texture.texture.region.position = Vector2(63*3, 0)

func _on_Events_LEVEL_FIFTH():
	akino_label.text = "5 / 5"
	akino_texture.texture.region.position = Vector2(63*4, 0)
