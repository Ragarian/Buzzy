extends Control

export(float) var screen_move_speed = 800

var current_screen = "start"
var old_size = Vector2()


onready var levels = get_node("levels")
onready var options = get_node("options")
onready var tween = get_node("tween")


func _ready():
	# Main menu buttons
	for node in get_node("buttons").get_children():
		if node extends BaseButton:
			if node.get_name() == "exit":
				node.connect("pressed", self, "quit")
			else:
				node.connect("pressed", self, "go_to_target", [node.get_name()])
	
	# Back buttons
	for node in get_children():
		if node.has_node("back"):
			node.get_node("back").connect("pressed", self, "go_to_target", ["start"])


func go_to_target(var screen = "start"):
	current_screen = screen
	
	var target_coordinates = Vector2(0, 0)
	if has_node(screen):
		target_coordinates = get_node(screen).get_pos()
	
	var current_coordinates = get_pos()
	var distance = current_coordinates.distance_to(target_coordinates)
	var time = distance/screen_move_speed
	
	if time > 0:
		tween.interpolate_property(self, "rect/pos", current_coordinates, -target_coordinates, time, Tween.TRANS_EXPO, Tween.EASE_OUT, 0)
		tween.start()

func quit():
	get_tree().quit() # Exit the game

	#level 1
func _on_level_1_pressed():
	get_node("levels/level_1/popup_1").show()
func _on_close_1_pressed():
	get_node("levels/level_1/popup_1").hide()
func _on_play_1_pressed():
	get_tree().change_scene("res://scene/area_1.tscn")

