extends Control

@onready var sfxSelection: AudioStreamPlayer = $AudioStreamPlayer

func _input(event):
	if event is InputEventKey:
		sfxSelection.play()

func _on_transition_animation_finished(anim_name: StringName):
	get_tree().change_scene_to_file("res://Scenes/Lista_de_Musicas.tscn")
