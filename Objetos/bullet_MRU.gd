extends CharacterBody2D


var velocidad = SignalBus.velocidad


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity = Vector2(velocidad, 0)

	var collide = move_and_collide(velocity * delta)
	if collide:
		if collide.get_collider().name == "TileMapLayer":
			queue_free()
			SignalBus.colision_pared.emit()
		elif collide.get_collider().name == "bullet":
			queue_free()
