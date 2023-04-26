extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var pool = PoolVector2Array([Vector2(0,0), Vector2(1,0), Vector2(0,1)])
	OS.set_window_mouse_passthrough(pool)

func _input(event):
	Globals.currently_foreground = false


# Called every frame. 'delta' is the elapsed time since the previous frame
#	pass
