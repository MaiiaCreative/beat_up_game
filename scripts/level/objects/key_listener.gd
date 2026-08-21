extends Sprite2D

@onready var falling_key = preload("res://Scripts/Level/Objects/falling_key.tscn")
@onready var score_text = preload("res://Scripts/Level/Objects/score_press_text.tscn")
@export var key_name: String = ""

var falling_key_queue = []

var perfect_press_threshold := 30.0
var great_press_threshold := 55.0
var good_press_threshold := 80.0
var ok_press_threshold := 105.0
var min_hit_threshold := 150.0

var perfect_press_score := 250
var great_press_score := 100
var good_press_score := 50
var ok_press_score := 20

var miss_sound_player: AudioStreamPlayer

func _ready():
	$GlowOverlay.frame = frame + 4
	SignalIs.CreateFallingKey.connect(CreateFallinKey)
	miss_sound_player = AudioStreamPlayer.new()
	miss_sound_player.stream = load("res://sounds/sfx/sfxFallNote.mp3")
	add_child(miss_sound_player)

func _process(_delta):
	if Input.is_action_just_pressed(key_name):
		SignalIs.KeyListenerPress.emit(key_name, frame)

	CleanFallingKeyQueue()
	
	if falling_key_queue.size() > 0:
		var current_key = falling_key_queue.front()
		
		if not IsKeyValid(current_key):
			falling_key_queue.pop_front()
			return
			
		if current_key.has_passed:
			falling_key_queue.pop_front()
			EmitMiss()
			return

		if Input.is_action_just_pressed(key_name):
			HandleKeyPress()

func CleanFallingKeyQueue():
	var valid_keys = []
	for key in falling_key_queue:
		if IsKeyValid(key):
			valid_keys.append(key)
	falling_key_queue = valid_keys

func IsKeyValid(key) -> bool:
	return key != null and is_instance_valid(key)

func HandleKeyPress():
	var key_to_pop = falling_key_queue.pop_front()
	
	if not IsKeyValid(key_to_pop):
		return
		
	var distance_from_key = abs(key_to_pop.global_position.y - global_position.y)
	if distance_from_key > min_hit_threshold:
		falling_key_queue.push_front(key_to_pop)
		return

	var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
	$AnimationPlayer.stop()
	$AnimationPlayer.play("key_hit")

	var press_score_text := ""
	if distance_from_pass < perfect_press_threshold:
		SignalIs.IncrementScore.emit(perfect_press_score)
		press_score_text = "PERFECT"
		SignalIs.IncrementCombo.emit()
		GameData.perfect_match += 1
	elif distance_from_pass < great_press_threshold:
		SignalIs.IncrementScore.emit(great_press_score)
		press_score_text = "GREAT"
		SignalIs.IncrementCombo.emit()
		GameData.great_match += 1
	elif distance_from_pass < good_press_threshold:
		SignalIs.IncrementScore.emit(good_press_score)
		press_score_text = "GOOD"
		SignalIs.IncrementCombo.emit()
		GameData.good_match += 1
	elif distance_from_pass < ok_press_threshold:
		SignalIs.IncrementScore.emit(ok_press_score)
		press_score_text = "OK"
		SignalIs.IncrementCombo.emit()
		GameData.ok_match += 1
	else:
		press_score_text = "MISS"
		SignalIs.ResetCombo.emit()
		miss_sound_player.stop()
		miss_sound_player.play()
		GameData.miss += 1

	key_to_pop.queue_free()
	ShowScoreText(press_score_text)

func EmitMiss():
	var st_inst = score_text.instantiate()
	get_tree().get_root().call_deferred("add_child", st_inst)
	st_inst.SetTextInfo("MISS")
	st_inst.global_position = global_position + Vector2(0, -20)
	SignalIs.ResetCombo.emit()
	miss_sound_player.stop()
	miss_sound_player.play()
	GameData.miss += 1

func ShowScoreText(text: String):
	var st_inst = score_text.instantiate()
	get_tree().get_root().call_deferred("add_child", st_inst)
	st_inst.SetTextInfo(text)
	st_inst.global_position = global_position + Vector2(0, -20)

func CreateFallinKey(button_name: String):
	if button_name == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.Setup(position.x, frame + 4)
		falling_key_queue.push_back(fk_inst)
