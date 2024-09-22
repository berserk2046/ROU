extends Area2D
var pixel_metro = 14.9090909091
var gravedad = 9.81
var altura_metros

func shoot():
	var bullet = load("res://Objetos/bullet_caida_libre.tscn")
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	SignalBus.bala_toca_suelo.connect(_on_bala_toco_piso)
	
func _on_slider_altura_value_changed(value: float) -> void:
	altura_metros = value / pixel_metro
	position.y = 328 - value
	get_node("../Altura").text = "Altura (%0.2f metros): " % altura_metros
	
func _on_bala_toco_piso():
	$"../VelocidadFinal".text = "Velocidad Final: %0.4fm/s" % sqrt(2*(gravedad)*altura_metros)
	$"../Tiempo".text = "Tiempo: %0.1fs" % sqrt((2*altura_metros)/gravedad)

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			shoot()
