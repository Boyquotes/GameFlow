extends TileMap

var StartPlatformPosition = 5
var StartPlatformPieces = 5
var StartPlatformDepth = 3

var CurrentPlacingPositionX = 0
var CurrentPlacingPositionY = 0

var GeneratingCell = Vector2(0,0)
var Generating = false
var SelectedBlock = Purple_Part
var PlacingOffsetX = 5
var PlacingOffsetY = 5

var LastPlacedXBlock = 0
var LastPlacedYBlock = 0

var debounce = false

var mydata = {}

enum {
	Purple_Part = 0,
	Red_Part = 1,
	Orange_Part = 2,
	Green_Part = 3,
	Blue_Part = 4,
	Doping_Test = 6,
	TreeTrunk = 7,
	Leaves = 8,
	Block = 5,
}

var platformarray = []

onready var player : KinematicBody2D = get_node("../Player")
const tester = preload("restart.tscn")
onready var SpawnLocation = player.position
onready var tile_map = $"."
onready var fallzone = $"../fallzone"

func CreateStartPlatform(x,y):
	CurrentPlacingPositionX += 1
	set_cell(x,y,SelectedBlock)
	
	if CurrentPlacingPositionX == 3:
		SpawnLocation = Vector2(x,y)

	if CurrentPlacingPositionX == StartPlatformPieces:
		GeneratingCell = Vector2(x,y)
		CurrentPlacingPositionX = 0

func CreatePart(x,y):
	set_cell(x,y,SelectedBlock)
	
func CreatePlatform(length,x,y):
	for i in length:
		set_cell(x + CurrentPlacingPositionX,y,SelectedBlock)
		
		LastPlacedXBlock = x
		var randomnum = randi()%7
		if randomnum == 2:
			set_cell(x+ CurrentPlacingPositionX, y-1, 8)
				
			
		CurrentPlacingPositionX += 1
	
func _physics_process(_delta):
	
	if Input.is_action_just_pressed("r"):
		get_tree().change_scene("res://World.tscn")
	
	if Generating:
		if debounce == false:
			#randomize()
			if CurrentPlacingPositionX == 0:
				var PlacingOffsetY = randi()%5
				var SelectionY = randi()%2
				
				for i in 5:
					#randomize()
					if SelectionY == 0:
						CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
						GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
					else:
						CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y + PlacingOffsetY)
						GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y + PlacingOffsetY)
						
			var PlayerPos = player.position
			var DistanceX = CurrentPlacingPositionX - world_to_map(player.position).x
			
			if DistanceX < 11:
				var PlacingOffsetY = randi()%4
				var SelectionY = randi()%2
				
				#print("Generated Next Path | Ends at ", GeneratingCell, " | You are at ",world_to_map(player.position))
				
				for i in 5:
					#randomize()
					if SelectionY == 0:
						CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
						
						platformarray.append(Vector2(GeneratingCell.x, GeneratingCell.y-1))
						
						GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
						
					else:
						if map_to_world(GeneratingCell).y > fallzone.position.y:
							CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y + PlacingOffsetY)
							platformarray.append(Vector2(GeneratingCell.x, GeneratingCell.y-1))
							
							# offsett for neste platform
							GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y + PlacingOffsetY)
						else:
							CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
							platformarray.append(Vector2(GeneratingCell.x, GeneratingCell.y-1))
							
							# offset for neste platform
							GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)

func _ready():
	randomize()
	Generating = true
	for Part in StartPlatformPieces:
		CreateStartPlatform(CurrentPlacingPositionX, StartPlatformPosition)
