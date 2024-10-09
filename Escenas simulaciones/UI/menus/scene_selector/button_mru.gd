extends Button

func _add_a_scene_menu_manually():
	var scene = SignalBus.scene_path
	get_tree().change_scene_to_file(scene)

func _ready():
	pressed.connect(self._quit_button_pressed)

func _quit_button_pressed():
	_add_a_scene_menu_manually()
