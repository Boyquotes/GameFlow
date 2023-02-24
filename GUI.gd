extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_parent()
onready var hp = player.hp
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var piller = player.pills
	piller = str(piller)
	$RichTextLabel2.text = piller
	var whey = player.whey
	whey = str(whey)
	$ColorRect2/RichTextLabel1.text = whey

	
