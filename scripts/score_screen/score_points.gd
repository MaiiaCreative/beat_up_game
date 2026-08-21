extends Control

@onready var perfect_label = $CanvasLayer/PERFECT_MATCHS
@onready var great_label = $CanvasLayer/GREAT_MATCHS
@onready var good_label = $CanvasLayer/GOOD_MATCHS
@onready var ok_label = $CanvasLayer/OK_MATCHS
@onready var miss_label = $CanvasLayer/MISS
@onready var sprite_rank = $"../RANK"

func _ready():
	update_all_labels()
	calcular_rank()

func update_all_labels():
	perfect_label.text = "PERFECT MATCHES: " + str(GameData.perfect_match)
	great_label.text = "GREAT MATCHES: " + str(GameData.great_match)
	good_label.text = "GOOD MATCHES: " + str(GameData.good_match)
	ok_label.text = "OK MATCHES: " + str(GameData.ok_match)
	miss_label.text = "MISSES: " + str(GameData.miss)

func calcular_rank():
	var pesos = {
		"perfect": 1.0,
		"great": 0.9,
		"good": 0.7,
		"ok": 0.5,
		"miss": 0.0
	}

	var total_notas = (
		GameData.perfect_match +
		GameData.great_match +
		GameData.good_match +
		GameData.ok_match +
		GameData.miss
	)

	if total_notas == 0:
		return "E"

	var score = (
		GameData.perfect_match * pesos["perfect"] +
		GameData.great_match * pesos["great"] +
		GameData.good_match * pesos["good"] +
		GameData.ok_match * pesos["ok"]
	)

	var porcentagem = (score / total_notas) * 100.0

	var rank := ""
	if porcentagem == 100.0:
		rank = "W"
		sprite_rank.texture = load("res://Sprites/Score_Screen/RANK_W.png")
	elif porcentagem >= 95.0:
		rank = "S"
		sprite_rank.texture = load("res://Sprites/Score_Screen/RANK_S.png")
	elif porcentagem >= 90.0:
		rank = "A"
		sprite_rank.texture = load("res://Sprites/Score_Screen/RANK_A.png")
	elif porcentagem >= 80.0:
		rank = "B"
		sprite_rank.texture = load("res://Sprites/Score_Screen/RANK_B.png")
	elif porcentagem >= 70.0:
		rank = "C"
		sprite_rank.texture = load("res://Sprites/Score_Screen/RANK_C.png")
	elif porcentagem >= 60.0:
		rank = "D"
		sprite_rank.texture = load("res://Sprites/Score_Screen/RANK_C.png")
	else:
		rank = "E"
		sprite_rank.texture = load("res://Sprites/Score_Screen/RANK_E.png")

	return rank
