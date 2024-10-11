extends Button

func _add_a_scene_menu_manually():
	get_tree().change_scene_to_file("res://Escenas simulaciones/UI/menus/scene_selector/Scene_Selection_Menu_1.tscn")

func _ready():
	text = "Prev Page"
	pressed.connect(self._prev_button_pressed)

func _prev_button_pressed():
	_add_a_scene_menu_manually()
