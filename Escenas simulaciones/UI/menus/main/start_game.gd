extends Button

func _add_a_scene_manually():
	get_tree().change_scene_to_file("res://Escenas simulaciones/UI/menus/scene_selector/Scene_Selection_Menu.tscn")

func _ready():
	text = "Start Game"
	pressed.connect(self._start_button_pressed)

func _start_button_pressed():
	_add_a_scene_manually()
