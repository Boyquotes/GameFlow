extends TileMap

var StartPlatformPosition = 5
var StartPlatformPieces = 5

var CurrentPlacingPosition = 0

enum {
	Part = 0,
}


func CreatePart(x,y,part):
	CurrentPlacingPosition += 1
	set_cell(x,y,part)
	print("X: ",x," Y: ",y)

func _ready():
	for Part in StartPlatformPieces:
		CreatePart(StartPlatformPosition, StartPlatformPosition, Part)
