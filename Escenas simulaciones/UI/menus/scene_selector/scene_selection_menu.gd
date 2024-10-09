extends Control

var options = ["Distancia", "Velocidad", "Tiempo"]
var current_index = 0

# Variables de botones
var button_mru
var left_arrow 
var right_arrow 

# Cargar iconos
var icon_velocidad
var icon_tiempo
var icon_distancia

func _ready():
	# Define las variables de los botones
	button_mru = $MarginContainer2/HBoxContainer/MRU/Button_mru
	left_arrow = $MarginContainer2/HBoxContainer/MRU/Left
	right_arrow = $MarginContainer2/HBoxContainer/MRU/Right
	update_display()

func update_display():
	print("index: ", current_index)
	if current_index == 2:
		icon_tiempo = load("res://texturas/boton_mru_tiempo.png")
		button_mru.icon = icon_tiempo
		SignalBus.scene_path  = "res://Escenas simulaciones/MRU/MRU_Tiempo/Movimiento Rectilinio Uniforme.tscn"
	elif current_index == 1:
		icon_velocidad = load("res://texturas/boton_mru_velocidad.png")
		button_mru.icon = icon_velocidad
		SignalBus.scene_path = "res://Escenas simulaciones/MRU/MRU_Velocidad/Movimiento Rectilinio Uniforme.tscn"
	elif current_index == 0:
		icon_distancia = load("res://texturas/button_distancia_mru.png")
		button_mru.icon = icon_distancia
		SignalBus.scene_path = "res://Escenas simulaciones/MRU/MRU_Distancia/Movimiento Rectilinio Uniforme.tscn"
	else:
		print("wrong index")


func _on_left_pressed() -> void:
	current_index = (current_index - 1 + options.size()) % options.size()
	print("index despues de presionar(l): ", current_index)
	update_display()


func _on_right_pressed() -> void:
	current_index = (current_index + 1) % options.size()
	print("index despues de presionar(r): ", current_index)
	update_display()
