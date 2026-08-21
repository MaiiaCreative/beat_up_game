extends ColorRect

@onready var sfx_applauses = $AudioStreamPlayer
@onready var sfx_selection = $AudioStreamPlayer2

func _ready():
	sfx_applauses.play()

func _input(event):
	if event is InputEventKey:
		#IDEIA PARA RANK: SALVAR A VARIAVEL SCORE DO SCORE POINTS EM UM ARRAY DE UM SCRIPT AUTOLOAD (CRIAR UM SCRIPT SÓ PRA ISSO)
		#O ARRAY TEM 3 VALORES, AO FINAL DE CADA MÚSICA, A VAR SCORE OCUPA UMA POSIÇÃO NESSE ARRAY, SE O SCORE FOR MAIOR QUE UM JA PRÉ EXISTENTE, ELE OCUPA ESTE LUGAR
		#A IDEIA É SER UM ARRAY POR MÚSICA
		GameData.reset_scores()
		sfx_selection.play()
		get_tree().change_scene_to_file("res://Scenes/Ranking_Screen.tscn")
