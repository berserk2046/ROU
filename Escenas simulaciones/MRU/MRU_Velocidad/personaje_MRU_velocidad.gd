extends Area2D
var pixel_metro = 18
var m_s
var k_h
var tiempo=0
var distancia = 0

func _on_distancia_slider_value_changed(value: float) -> void:
	pixel_metro = $"../distancia_slider".max_value - value
	distancia = (1152/pixel_metro)
	get_node("../distancia_label").text = "Distancia (%0.2fkm): " % distancia
	distancia = distancia * 1000

func _on_tiempo_slider_value_changed(value: float) -> void:
	tiempo = value
	get_node("../tiempo_label").text = "Tiempo (%0.2fs): " % value

func shoot():
	SignalBus.velocidad = ((distancia/1000) / tiempo) * pixel_metro
	var bullet = load("res://Objetos/bullet_MRU.tscn")
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	SignalBus.colision_pared.connect(_on_colision_pared)


func _on_colision_pared():
	m_s = (SignalBus.velocidad*1000) / pixel_metro
	k_h = 3.6 * m_s
	get_node("../velocidad_label").text = "Velocidad: %0.4fkm/h" % k_h


func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			shoot()
