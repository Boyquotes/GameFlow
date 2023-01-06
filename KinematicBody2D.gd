extends KinematicBody2D

# Player Values #
const speed = 200 #200
const jump = -350
const gravity = 20

var jumps = 0
var extrajumps = 1
const UP = Vector2(0, -1)
var motion = Vector2()

# Player Camera #
onready var PlayerCamera = $Camera2D
const CameraMaxZoom = 0.6
const CameraMinZoom = 0.3

func _physics_process(_delta):
	
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
	else:
		motion.x = 0
		
	if Input.is_action_just_pressed("ui_up"):
		if jumps < extrajumps:
			motion.y = jump
			jumps += 1
		
	if is_on_floor():
		jumps = 0
	
	motion = move_and_slide(motion, UP)
