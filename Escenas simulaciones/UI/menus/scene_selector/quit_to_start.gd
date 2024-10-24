extends Button

func _add_a_scene_menu_manually():
	get_tree().change_scene_to_file("res://Escenas simulaciones/UI/menus/main/main_menu.tscn")

func _ready():
	text = "Menu principal"
	pressed.connect(self._next_button_pressed)

func _next_button_pressed():
	_add_a_scene_menu_manually()
