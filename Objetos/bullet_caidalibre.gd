extends RigidBody2D



var velocidad = 2*Vector2(0, 0)  # Velocidad inicial
var aceleracion = Vector2(0, 14.90909091*9.81)  # Gravedad (en píxeles por segundo)
var on_floor_time  = 0

func _integrate_forces(state):
	# Calcula la nueva velocidad
	print(on_floor_time)

	var i := 0
	while i < state.get_contact_count():
		var normal = state.get_contact_local_normal(i)
		var this_contact_on_floor = normal.dot(Vector2.UP) > 0.99
		
		if this_contact_on_floor:
			on_floor_time = Time.get_ticks_msec()
			break
		i += 1
	if(on_floor_time > 0.99):
		print(Vector2(sqrt(velocidad.x), sqrt(velocidad.y)))
		velocidad += Vector2(0,0) * state.step
	else:
		velocidad += 2 * aceleracion * (state.step)  # Asigna la velocidad a la bala
	linear_velocity = velocidad

func _on_body_entered(body: Node) -> void:
	print("Colission con: ", body.name)
	if body.is_in_group("piso"):
		queue_free()
		SignalBus.bala_toca_suelo.emit()
