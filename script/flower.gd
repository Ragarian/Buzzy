
extends Area2D

# Member variables
var taken = false

func _on_flower_body_enter( body ):
		if (not taken and body extends preload("res://script/player.gd")):
			get_node("anim").play("took")
			taken = true
			