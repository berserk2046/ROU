extends CharacterBody2D

# variables principales
var velocidad
var v_inicial
var pixel_metro = 18
var m_s
var k_h
var aceleracion_px; var aceleracion = 0; var a_inicial = 0
var physics_process_running = false # verificar si physics_process es falso o verdadero
var esta_acelerando = false
var i = 0 # permite verificar  valor de aceleracion

func _ready(): set_physics_process(false)

func _physics_process(delta: float) -> void:
	if esta_acelerando: apply_acceleration(delta)
	velocity = Vector2(velocidad, 0)
	var collide = move_and_collide(velocity * delta)
	if collide:
		if collide.get_collider().name == "TileMapLayer":
			self.transform = Transform2D(0, Vector2(76,307))
			_on_colision_pared()
			esta_acelerando = false
			set_physics_process(false)
			physics_process_running = false
			velocidad = v_inicial
			print("Running: ", physics_process_running)

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			set_physics_process(true)
			iniciar_accel()

func iniciar_accel(): esta_acelerando = true

func apply_acceleration(delta: float): 
	velocidad += aceleracion_px * delta
	aceleracion = velocidad-v_inicial
	#print("Aceleracion: ", (aceleracion)/pixel_metro)

func _on_aceleracion_slider_value_changed(value: float) -> void:
	aceleracion_px = value * pixel_metro
	a_inicial = value
	$"../aceleracion_label".text = "Aceleracion (%0.2fm/s^2): " % value

func _on_distancia_slider_value_changed(value: float) -> void: 
	pixel_metro = $"../distancia_slider".max_value - value
	if pixel_metro < 1: pixel_metro = 5.76
	print("value: ", $"../distancia_slider".max_value - value)
	get_node("../distancia_label").text = "Distancia (%0.2fm): " % (1152/pixel_metro)

func _on_velocidad_slider_value_changed(value: float) -> void:
	v_inicial = value
	velocidad = value
	m_s = v_inicial / pixel_metro
	k_h = m_s * 3.6
	get_node("../velocidad_label").text = "Velocidad Inicial (%0.2fkm/h): " % k_h


func _on_colision_pared():
	# variables para encontrar tiempo
	var a = a_inicial / 2; var b = (v_inicial / pixel_metro); var c = -1152/pixel_metro 
	#print("a: ", a, "b: ", b, "c: ",c)
	var dicriminante = (b*b) - (4*a*c); var raiz_dicriminante = sqrt(dicriminante);
	#print("Dicriminante: ", dicriminante); print("Raiz Dicriminante: ", raiz_dicriminante)
	#print("Resta: ", (-b)+raiz_dicriminante); print("2a: ", 2*a)
	var resta = (-b)+raiz_dicriminante; var a2 = 2*a;
	var tiempo = resta/a2
	get_node("../tiempo_label").text = "Tiempo: %0.4f" % tiempo
	var vf_km = (velocidad/pixel_metro) * 3.6
	get_node("../vf_label").text = "Velocidad Final: %0.4fkm/h" % vf_km
	var v_prom = (((velocidad + v_inicial)/pixel_metro)/2) * 3.6
	get_node("../v_prom").text = "Velocidad Promedio: %0.4fkm/h" % v_prom

func wait(segundos:float): 
	await get_tree().create_timer(segundos).timeout
