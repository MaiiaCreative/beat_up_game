extends ColorRect

var options := ["TUTORIAL","SODA_CITY", "TANK", "HAIYOROKONDE", "SAMBA_DE_AMIGO", "MOB_CHOIR_99","BLING_BANG_BANG_BORN", "WE_ARE", "CHA_LA_HEAD_CHA_LA", "CATCH_YOU_CATCH_ME", "A_CRUEL_ANGEL'S_THESIS", "EXIT"]

var index := 0
var dist := 55
var custom_font = load("res://Fonts/VCR_OSD_MONO_1.001.ttf")
var font_size := 50

var goto_music: bool = false

@onready var sfx_list = $AudioStreamPlayer
@onready var sfx_select = $AudioStreamPlayer2

func _ready():
	if not custom_font:
		push_warning("Fonte não encontrada! Usando fonte padrão.")
		custom_font = ThemeDB.fallback_font
		set_process(true)

func _process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		index = (index + 1) % options.size()
		queue_redraw()
	
	if Input.is_action_just_pressed("ui_up"):
		index = (index - 1 + options.size()) % options.size()
		queue_redraw()
	
	if Input.is_action_just_pressed("ui_accept"):
		sfx_select.play()
		_handle_selection()

func _draw():
	var viewport_width = get_viewport_rect().size.x
	var start_y = 270
	
	for i in range(options.size()):
		var text = options[i]
		var text_size = custom_font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
		var base_x = viewport_width - 500 - text_size.x  # Alinha à direita
		var x_offset = -50 if i == index else 0  # Selecionado: move 20px para esquerda
		var position = Vector2(base_x + x_offset, start_y + i * dist)
		var color = Color.YELLOW if i == index else Color.WHITE
		
		draw_string(
			custom_font,
			position,
			text,
			HORIZONTAL_ALIGNMENT_LEFT,
			-1,
			font_size,
			color
		)

func _handle_selection():
	match index:
		0: _change_scene("res://Scenes/Musicas/RYTHM_HELL.tscn")
		1: _change_scene("res://Scenes/Musicas/SODA_CITY.tscn")
		2: _change_scene("res://Scenes/Musicas/TANK.tscn")
		3: _change_scene("res://Scenes/Musicas/HAYOROKONDE.tscn")
		4: _change_scene("res://Scenes/Musicas/SAMBA_DE_AMIGO.tscn")
		5: _change_scene("res://Scenes/Musicas/MOB_CHOIR_99.tscn")
		6: _change_scene("res://Scenes/Musicas/BLING_BANG_BANG_BORN.tscn")
		7: _change_scene("res://Scenes/Musicas/WE_ARE.tscn")
		8: _change_scene("res://Scenes/Musicas/CHA_LA_HEAD_CHA_LA.tscn")
		9: _change_scene("res://Scenes/Musicas/CATCH_YOU_CATCH_ME.tscn")
		10: _change_scene("res://Scenes/Musicas/A_CRUEL_ANGELS_THESIS.tscn")
		11: get_tree().quit()

func _change_scene(scene_path: String):
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
