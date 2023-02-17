extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


onready var player : KinematicBody2D = get_node("../Player")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		#get_tree().change_scene("res://World.tscn")
		queue_free()
