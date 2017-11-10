extends KinematicBody2D

const lift_speed = 370 #pixels/second
const drop_speed = 200
const flight_speed = 200 #side to side speed
var power = 100
var collect = 0

onready var main_fuel = get_node("gui/HBoxContainer/ProgressBar")
onready var collect_tank = get_node("gui/collect")


func _fixed_process(delta):
	
	var motion = Vector2()
	var lift = Vector2()
	var drop = Vector2()
	
	drop += Vector2(0, 1)
	collect_tank.set_value(collect)
	
	if (Input.is_action_pressed("move_up")):
		lift += Vector2(0, -2)
		power -= 3*delta
		main_fuel.set_value(power)
		if (power <= 0):
			_end_game()
		
	if (Input.is_action_pressed("move_left")):
		motion += Vector2(-1, 0)
		get_node("sprite").set_scale(Vector2(-1, 1))
	if (Input.is_action_pressed("move_right")):
		motion += Vector2(1, 0)
		get_node("sprite").set_scale(Vector2(1, 1))
	
	lift = lift.normalized()*lift_speed*delta
	move(lift)
	drop = drop.normalized()*drop_speed*delta
	move(drop)
	motion = motion.normalized()*flight_speed*delta
	move(motion)


func _ready():
	set_fixed_process(true)
	main_fuel.set_value(power)
	collect_tank.set_value(collect)
	
func _end_game():
	# add ingame menu and crash bee
	set_fixed_process(false)
