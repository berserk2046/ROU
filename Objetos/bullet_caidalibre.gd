extends RigidBody2D



var velocidad = 2*Vector2(0, 0)  # Velocidad inicial
var aceleracion = Vector2(0, 14.90909091*SignalBus.gravedad)  # Gravedad (en píxeles por segundo)
var on_floor_time  = 0

# Como physics_process basicamente
func _integrate_forces(state):
	# Calcula la nueva velocidad
	print(on_floor_time)

	var i := 0
	while i < state.get_contact_count(): # manejar la colision
		var normal = state.get_contact_local_normal(i) # chequear la direccion de la colision
		var this_contact_on_floor = normal.dot(Vector2.UP) > 0.99 # si el vector mira hacia arriba, entonces es contacto con suelo
		
		if this_contact_on_floor:
			on_floor_time = Time.get_ticks_msec() # tiempo que pasa en contacto con el suelo
			break
		i += 1
	if(on_floor_time > 0.99):
		print(Vector2(sqrt(velocidad.x), sqrt(velocidad.y))) # Velocidad final
		velocidad += Vector2(0,0) * state.step # si esta en el suelo entonces no cambia la velocidad
	else:
		velocidad += 2 * aceleracion * (state.step)  # Asigna la velocidad a la bala y su aceleracion
	linear_velocity = velocidad

func _on_body_entered(body: Node) -> void:
	print("Colission con: ", body.name)
	if body.is_in_group("piso"):
		queue_free()
		SignalBus.bala_toca_suelo.emit()
