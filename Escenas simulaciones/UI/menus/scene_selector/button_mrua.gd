extends Button

var scene =  "res://Escenas simulaciones/MRUA/Movimiento Rectilinio Uniforme.tscn"
func _add_a_scene_menu_manually():
	get_tree().change_scene_to_file(scene)

func _ready():
	pressed.connect(self._quit_button_pressed)

func _quit_button_pressed():
	_add_a_scene_menu_manually()
