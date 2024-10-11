extends Area2D
var pixel_metro = 18
var m_s
var k_h
var tiempo = 0
var distancia_px
var distancia = 0

func shoot():
	var bullet = load("res://Objetos/bullet_MRU.tscn")
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	SignalBus.colision_pared.connect(_on_colision_pared)

func _on_tiempo_slider_value_changed(value: float) -> void:
	tiempo = value
	get_node("../tiempo_label").text = "Tiempo (%0.2fs): " % value
 
func _on_velocidad_slider_value_changed(value: float) -> void:
	if tiempo == 0: tiempo = 1
	SignalBus.velocidad = 1152/tiempo
	m_s = value / pixel_metro
	k_h = m_s * 3.6
	get_node("../velocidad_label").text = "Velocidad (%0.2fkm/h): " % k_h

func _on_colision_pared():
	distancia = m_s * tiempo
	get_node("../distancia_label").text = "Distancia: %0.4fm" % distancia


func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			var v_value = $"../velocidad_slider".value
			if v_value < 1: get_node("../error_label").text = "Error: Dele un valor a la velocidad."
			else: print("value: ", v_value); shoot()
