extends Button

func _add_a_scene_menu_manually():
	get_tree().change_scene_to_file("res://Escenas simulaciones/UI/menus/scene_selector/Scene_Selection_Menu_2.tscn")

func _ready():
	text = "Next Page"
	pressed.connect(self._next_button_pressed)

func _next_button_pressed():
	_add_a_scene_menu_manually()
