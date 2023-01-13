extends TileMap

var StartPlatformPosition = 5
var StartPlatformPieces = 5
var StartPlatformDepth = 3

var CurrentPlacingPositionX = 0
var CurrentPlacingPositionY = 0

var GeneratingCell = Vector2(0,0)
var Generating = false

enum {
	Part = 0,
}

func CreateStartPlatform(x,y):
	CurrentPlacingPositionX += 1
	set_cell(x,y,Part)
	
	if CurrentPlacingPositionX == StartPlatformPieces:
		GeneratingCell = Vector2(x,y)
		CurrentPlacingPositionX = 0
		
func CreatePart(x,y):
	set_cell(x,y,Part)
	
func CreatePlatform(length,x,y):
	for i in length: 
		set_cell(x + CurrentPlacingPositionX,y,Part)
		CurrentPlacingPositionX += 1
	
func _physics_process(delta):
	if Generating:
		var PlacingOffsetX = 4
		var PlacingOffsetY = randi()%4
		CreatePlatform(randi()%9,GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
		
		GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)

func _ready():
	Generating = true
	for Part in StartPlatformPieces:
		CreateStartPlatform(CurrentPlacingPositionX, StartPlatformPosition)
