extends RigidBody2D

func shoot():
	var bullet = load("res://Objetos/bullet_caida_libre.tscn")
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform

func get_input():
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func _physics_process(delta):
	get_input() 
