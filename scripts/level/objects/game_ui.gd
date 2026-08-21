extends Control

var score: int = 0
var combo_count: int = 0

func _ready():
	SignalIs.IncrementScore.connect(IncrementScore)
	SignalIs.IncrementCombo.connect(IncrementCombo)
	SignalIs.ResetCombo.connect(ResetCombo)
	
	ResetCombo()

func _process(_delta):
	z_index = 0

func IncrementScore(Incr: int):
	score += Incr
	%ScoreLabel.text = str(score) + " PTS"

func IncrementCombo():
	combo_count += 1
	$%ComboLabel.text = str(combo_count) + "X COMBO"

func ResetCombo():
	combo_count = 0
	$%ComboLabel.text = "OX COMBO"
