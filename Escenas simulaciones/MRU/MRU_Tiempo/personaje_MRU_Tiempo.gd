extends Area2D
var pixel_metro = 18
var distancia_px
var pre_tiempo
var m_s
var k_h

func shoot():
	var bullet = load("res://Objetos/bullet_MRU.tscn")
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	SignalBus.colision_pared.connect(_on_colision_pared)

func _on_distancia_slider_value_changed(value: float) -> void:
	distancia_px = 1152+value
	get_node("../distancia_label").text = "Distancia (%0.2fm): " % (distancia_px/pixel_metro)

func _on_velocidad_slider_value_changed(value: float) -> void:
	pre_tiempo = distancia_px / value # Calcular tiempo en el caso hipotetico de que la distancia si aumentara
	SignalBus.velocidad = 1152/pre_tiempo # Calcular la velocidad mostrada en base al tiempo hipotetico
	m_s = SignalBus.velocidad / pixel_metro
	k_h = m_s * 3.6
	get_node("../velocidad_label").text = "Velocidad (%0.2fkm/h): " % k_h


func _on_colision_pared():
	get_node("../tiempo_label").text = "Tiempo: %0.4f" % ((distancia_px/pixel_metro) / m_s)


func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			shoot()