extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2(1, 0)
# Called when the node enters the scene tree for the first time.
onready var player = $"../Player"
onready var deathwall = $"."
# Called every frame. 'delta' is the elapsed time since the previous frame.	


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://World.tscn")
		


var reset_distance = 350
var sprite

##func _ready():
	##sprite = get_node("../Sprite")

func _process(delta):
	position += velocity
	print(player.position.distance_to(deathwall.position))
	if player.position.distance_to(deathwall.position) >= reset_distance:
		deathwall.position.x = player.position.x - 50

