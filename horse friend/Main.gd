extends Node2D


var gen_x = RandomNumberGenerator.new()
var gen_y = RandomNumberGenerator.new()
var up_down = RandomNumberGenerator.new()
var coord_x = 0
var coord_y = 0
var direction = 0

export var speed_multi := 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#THE KEY IS MAKING THE STARTING SIZE SMALL AND THE SCREEN SIZE THE SIZE OF THE SYSTEM MONITOR SIZE. IDK WHY BUT THIS MAKES KEYBOARD PASSTHRU WORK
	get_tree().get_root().set_transparent_background(true)
	var size = OS.get_screen_size()
	size.y -= 100
	size.x -= 100
	OS.set_window_size(size)
	#OS.set_window_mouse_passthrough($Polygon2D.polygon)


# Called every frame. 'delta' is the elapsed time since the previous frame.jjjjjjjjjjjjj
func _process(delta):
	#OS.move_window_to_foreground()
	pass

func _input(event):
	pass

#

#func _on_Timer_timeout():
#	if !Input.is_action_just_pressed("key") && !Input.is_action_pressed("key") && !Input.is_action_just_released("key"):
#		OS.move_window_to_foreground()
	

	
