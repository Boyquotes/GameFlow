extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	position.x = $"../Player".position.x
	
	


func _on_fallzone_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://World.tscn")
