extends Node

# Caida Libre
signal bala_toca_suelo()
var gravedad = 9.81

# MRU
var velocidad = 0
signal colision_pared()

# Scenes Selector
# MRU
var scene_path: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
