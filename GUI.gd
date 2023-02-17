extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_parent()
onready var hp = player.hp
onready var color_rect = get_node("ColorRect3/ColorRect4")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var piller = player.pills
	piller = str(piller)
	$TextureRect/RichTextLabel.text = piller
	var whey = player.whey
	whey = str(whey)
	$ColorRect2/TextureRect3/RichTextLabel1.text = whey
	var hp = player.hp
	hp = str(hp)
	$ColorRect3/RichTextLabel.text = hp
		
#if hp = 100:
	#color_rect.set_size(Vector2(200, 100))
	
	
