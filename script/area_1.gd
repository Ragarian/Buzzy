extends Node2D

var collect = 0
var value = 1
func _ready():
	pass


func _on_flower_body_enter( body ):
	if (body.get_name() == "player"):
		collect += value
		get_node("player/gui/collect").set_value(collect)