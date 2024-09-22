extends CharacterBody2D

const GRAVITY = 20.0
const speed = 800

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	velocity.x = speed
	if is_on_floor():
		velocity.y = 0
		velocity.x = 0
	move_and_slide()
