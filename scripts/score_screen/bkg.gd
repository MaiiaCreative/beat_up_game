extends TextureRect

@export var textures: Array[Texture2D] = [
	preload("res://Sprites/Score_Screen/Score_BKG.png"),
	preload("res://Sprites/Score_Screen/Score_BKG2.png")
]

var current_texture_index := 0

func _ready():
	$Timer.wait_time = 0.5
	$Timer.timeout.connect(_change_texture)
	$Timer.start()
	
	if textures.size() > 0:
		texture = textures[0]

func _change_texture():
	if textures.size() == 0:
		return
	current_texture_index = (current_texture_index + 1) % textures.size()
	texture = textures[current_texture_index]
