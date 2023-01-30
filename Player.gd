extends KinematicBody2D
class_name Player
enum {MOVE, CLIMB}
#variabler
var velocity = Vector2.ZERO
var hp = 10
var fast_fell = false
var state = MOVE
onready var animatedSprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	match state:
		MOVE: move_state(input)
	
func move_state(input):	
	
	apply_gravity() #apply gravity function makes it so if character isnt on floor or a ladder they fall.
	if input.x == 0: #checks if character is moving left or right
		apply_friction()
		animatedSprite.animation = "Idle"
	else:
		apply_acceleration(input.x)
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = input.x < 0

	if is_on_floor(): #if they are on floor or coyote jumping the fast fell flag is reset
		fast_fell = false
		
		input_jump() #handles jump logic
	else:  
		animatedSprite.animation = "Jump"
		if Input.is_action_just_released("ui_up") and velocity.y < -250: #if the character is on floor, checks for jump input and applies jumpe force to character if detected
			velocity.y = -250
			
		
		if velocity.y  > 10 and not fast_fell: #If the character is falling at a high speed and the "fast fell" flag is not set, the function applies additional gravity to the character to increase their falling.
			velocity.y += 2
			fast_fell = true
	var was_in_air = is_on_floor()
	var was_on_floor = is_on_floor()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var just_landed = is_on_floor() and not was_in_air
	if just_landed:
		animatedSprite.animation = "Run"
		animatedSprite.frame = 1
	
	var just_left_ground = not is_on_floor() and was_on_floor
func input_jump():
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -250

func apply_gravity():
	velocity.y += 5
	velocity.y = min(velocity.y, 300) 
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 10)
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, 150 * amount, 10)
func player_dies():
	queue_free()
	animatedSprite.animation = "Die"
	

	
