extends TileMap

var StartPlatformPosition = 5
var StartPlatformPieces = 5
var StartPlatformDepth = 3

var CurrentPlacingPositionX = 0
var CurrentPlacingPositionY = 0

var GeneratingCell = Vector2(0,0)
var Generating = false
var SelectedBlock = Block

var MiddlePlatform = Vector2(0,0)

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

onready var player : KinematicBody2D = get_node("../Player")
const tester = preload("restart.tscn")
onready var SpawnLocation = player.position
onready var tile_map = $"."

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
		
		if i == length/2:
			
			MiddlePlatform = tile_map.map_to_world(Vector2(x,y-1))
			
			if randi()%5 == 1:
				randomize()
				var testcap = tester.instance()
				get_parent().add_child(testcap)
				
				testcap.position = MiddlePlatform
			
		CurrentPlacingPositionX += 1
	
func _physics_process(_delta):
	
	if Input.is_action_just_pressed("r"):
		get_tree().change_scene("res://World.tscn")
	
	if Generating:
		
		if GeneratingCell.x > 60000:
			Generating = false
		
		var PlacingOffsetX = 4
		var PlacingOffsetY = randi()%5
		var SelectionY = randi()%2
		if SelectionY == 0:
			CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
			GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
		else:
			var Island = randi()%20
			if Island == 3:
				CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y + PlacingOffsetY)
				GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y + PlacingOffsetY)
			else:
				CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y + PlacingOffsetY)
				GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y + PlacingOffsetY)

func _ready():
	randomize()
	Generating = true
	for Part in StartPlatformPieces:
		CreateStartPlatform(CurrentPlacingPositionX, StartPlatformPosition)
