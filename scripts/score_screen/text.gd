extends Label

@onready var sfx_selection = $"../AudioStreamPlayer2"
var go_to_list: bool = false

func _input(event):
	if event is InputEventKey and go_to_list:
		sfx_selection.play()
		get_tree().change_scene_to_file("res://Scenes/Lista_de_Musicas.tscn")

func _on_timer_timeout() -> void:
	go_to_list = true
