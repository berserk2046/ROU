extends Button

var simultaneous_scene = preload("res://Escenas simulaciones/caida libre.tscn").instantiate()

func _add_a_scene_manually():
	# This is like autoloading the scene, only
	# it happens after already loading the main scene.
	get_tree().root.add_child(simultaneous_scene)

func _ready():
	var button = Button.new()
	button.text = "Caida Libre"
	button.pressed.connect(self._button_pressed)
	add_child(button)

func _button_pressed():
	_add_a_scene_manually()
