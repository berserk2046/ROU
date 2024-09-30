extends Area2D
var pixel_metro = 18
var m_s
var k_h

func shoot():
	var bullet = load("res://Objetos/bullet_MRU.tscn")
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	SignalBus.colision_pared.connect(_on_colision_pared)

func _on_distancia_slider_value_changed(value: float) -> void:
	pixel_metro = $"../distancia_slider".max_value - value
	get_node("../distancia_label").text = "Distancia (%0.2fkm): " % (1152/pixel_metro)

func _on_velocidad_slider_value_changed(value: float) -> void:
	SignalBus.velocidad = value
	m_s = SignalBus.velocidad / pixel_metro
	k_h = m_s * 3.6
	get_node("../velocidad_label").text = "Velocidad (%0.2fkm/h): " % k_h


func _on_colision_pared():
	get_node("../tiempo_label").text = "Tiempo: %0.4f" % ((1152/pixel_metro)/m_s)


func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			shoot()
