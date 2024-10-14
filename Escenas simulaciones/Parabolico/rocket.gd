extends CharacterBody2D

# variables principales
var velocidad = Vector2()
var gravity = Vector2(0, 9.81*18)
var v_inicial = 0
var pixel_metro = 18
var m_s = 0
var k_h = 0
var angulo_lanzamiento = 0;
var physics_process_running = false # verificar si physics_process es falso o verdadero

func _ready(): set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocidad.y += gravity.y*delta
	velocity = velocity*delta # modificar la velocity para que move_and_slide() pueda funcionar y detecte colision
	self.position += velocidad * delta
	# Indicador de objeto por fuera de pantalla
	if self.position.y < 0: 
		get_node("../above_indicator").texture = load("res://texturas/above_indicator.png")
		get_node("../above_indicator").set_size(Vector2(30,50))
		get_node("../above_indicator").position = Vector2(self.position.x + 20, 0)
	else: 
		get_node("../above_indicator").texture = null
		get_node("../above_indicator").position = Vector2(0,0)
	var collide = move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("collision with: ", collision)
		if collision.get_collider().name == "TileMapLayer" or collision.get_collider().name == "piso":
			self.transform = Transform2D(0, Vector2(76,307))
			_on_colision_pared()
			set_physics_process(false)
			physics_process_running = false
			velocidad = Vector2()
			print("Running: ", physics_process_running)

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_accept"):
			if $"../velocidad_slider".value == 0: get_node("../error_label").text = "Error: Dele valor a la velocidad inicial"
			else:			
				get_node("../error_label").text = ""
				set_physics_process(true)
				self.rotation  = ($"../angle_slider".max_value * PI/180) - (angulo_lanzamiento*PI/180)
				movimiento_parabolico()


func _on_velocidad_slider_value_changed(value: float) -> void:
	v_inicial = value 
	m_s = v_inicial / pixel_metro
	k_h = m_s * 3.6
	get_node("../velocidad_label").text = "Velocidad Inicial (%0.2fkm/h): " % k_h

func movimiento_parabolico():
	var angulo_lan_rad = angulo_lanzamiento * PI / 180
	velocidad.x = v_inicial*cos(angulo_lan_rad)
	velocidad.y =-v_inicial*sin(angulo_lan_rad)

func _on_colision_pared():
	#tiempo vuelo
	var tiempo_vuelo = ((2*m_s) * sin(angulo_lanzamiento*PI/180)) / (gravity.y/18)
	get_node("../tiempo_label").text = "Tiempo Vuelo: %0.2fs" % tiempo_vuelo
	# altura maxima
	var v_y = m_s*sin(angulo_lanzamiento*PI/180)
	var altura_maxima = (v_y * v_y) / (2*(gravity.y/18))
	get_node("../altura_label").text = "Altura Maxima: %0.2fm" % altura_maxima
	# distancia recorrida
	var distancia_recorrida = ((m_s*m_s) * sin(2*angulo_lanzamiento*PI/180)) / (gravity.y/18)
	get_node("../distancia_label").text = "Distancia Recorrida: %0.2fm" % distancia_recorrida

func _on_angle_slider_value_changed(value: float) -> void:
	angulo_lanzamiento = value
	get_node("../angle_label").text = "Angulo (%0.2f degrees): " % angulo_lanzamiento
