extends KinematicBody2D

var velocity = Vector2(100, 0)

func _physics_process(delta):
	var motion = velocity * delta
	move_and_collide(motion)


