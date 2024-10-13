extends Area2D
var pixel_metro = 18
var m_s
var k_h
var tiempo=1
var distancia_px = 0; var distancia

func _on_distancia_slider_value_changed(value: float) -> void:
	distancia_px =  value
	distancia = distancia_px / pixel_metro
	get_node("../distancia_label").text = "Distancia (%0.2f m): " % distancia


func _on_tiempo_slider_value_changed(value: float) -> void:
	tiempo = value
	get_node("../tiempo_label").text = "Tiempo (%0.2fs): " % value

func shoot():
	SignalBus.velocidad = 1152/tiempo
	var bullet = load("res://Objetos/bullet_MRU.tscn")
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	SignalBus.colision_pared.connect(_on_colision_pared)


func _on_colision_pared():
	m_s = distancia / tiempo
	k_h = 3.6 * m_s
	get_node("../velocidad_label").text = "Velocidad: %0.2fkm/h" % k_h


func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			if $"../distancia_slider".value == 0: get_node("../error_label").text = "Error: Dele un valor a la distancia"
			else: get_node("../error_label").text="";shoot()
