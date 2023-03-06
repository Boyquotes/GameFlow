extends KinematicBody2D
enum {MOVE, CLIMB}
#variabler
var velocity = Vector2.ZERO
var hp = 100
var fast_fell = false
var state = MOVE
var pills = 0
var whey = 0
onready var animatedSprite = $AnimatedSprite
onready var player = $"."
onready var tilemap = $"../TileMap"
onready var collision_shape = player.get_node("CollisionShape2D")

var Speed = 500
var Jump = 250

var tile_index

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var new_pos = position + velocity * delta
	var tile_pos = tilemap.world_to_map(new_pos)
	var tile_index = tilemap.get_cellv(tile_pos)
	if tile_index == 8:
		get_tree().change_scene("res://World.tscn")

		
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	match state:
		MOVE: move_state(input)
	if hp == 0:
		player_dies()
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
	if Input.is_action_pressed("ui_up"):
		velocity.y = -Jump

func apply_gravity():
	velocity.y += 5
	velocity.y = min(velocity.y, 300) 
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 10)
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, Speed * amount, 10)
func player_dies():
	queue_free()
	animatedSprite.animation = "Die"
