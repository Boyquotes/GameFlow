extends TileMap

var StartPlatformPosition = 5
var StartPlatformPieces = 5

var CurrentPlacingPosition = 0

enum {
	Part = 0,
}

<<<<<<< Updated upstream
=======
func CreatePlatForm(length,x,y):
	print(length,x,y)

func CreateStartPlatform(x,y):
	CurrentPlacingPositionX += 1
	set_cell(x,y,Part)
	
	if CurrentPlacingPositionX == StartPlatformPieces:
		GeneratingCell = Vector2(x,y)
		CurrentPlacingPositionX = 0
		
func CreatePart(x,y):
	set_cell(x,y,Part)
	
func _physics_process(delta):
	if(Input.is_action_pressed("mb_right")):
		var PlacingOffsetX = 5
		var PlacingOffsetY = 5
		CreatePart(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
		
		GeneratingCell = Vector2(GeneratingCell.x + PlacingOffsetX, GeneratingCell.y - PlacingOffsetY)
>>>>>>> Stashed changes

func CreatePart(x,y,part):
	CurrentPlacingPosition += 1
	set_cell(x+CurrentPlacingPosition,y,part)
	print("X: ",x," Y: ",y)
	
func _ready():
	for Part in StartPlatformPieces:
		CreatePart(StartPlatformPosition, StartPlatformPosition, Part)
