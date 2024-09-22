extends Area2D

var speed = 750
var accelaration = 10

func _physics_process(delta):
	position += (transform.x * speed * delta)- accelaration
