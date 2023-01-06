extends TileMap

var StartPlatformPosition = 5
var StartPlatformPieces = 5

enum {
	Part = 0,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var CurrentPlacingPosition = 0
	
	for Part in StartPlatformPieces:
		set_cell(CurrentPlacingPosition,StartPlatformPosition,Part)
		print(CurrentPlacingPosition)
		CurrentPlacingPosition += 1
