extends Button

var caida_libre = preload("res://Escenas simulaciones/caida libre/caida libre.tscn")

func _add_a_scene_manually():
	get_tree().change_scene_to_packed(caida_libre)

func _ready():
	text = "Start Game"
	pressed.connect(self._start_button_pressed)

func _start_button_pressed():
	_add_a_scene_manually()
