extends KinematicBody2D

enum {
	IDLE,
	WANDER
}

var size = OS.get_screen_size()
var prev_state = "none"


var velocity = Vector2.ZERO
var state = IDLE
var rng = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()
var which_way = 0
var color = 0

const ACCELERATION = 800
const MAX_SPEED = 100
const TOLERANCE = 4.0

onready var start_position = global_position
onready var target_position = global_position

func _ready():
	rng.randomize()
	rng2.randomize()
	size.x -= 300
	size.y -= 300
	color = rng2.randi_range(1,5)

func lets_move(movement): #there has to be a better way to do this
	match color:
		1:
			match movement:
				"right":
					get_node("Horse").play("blright")
				"left":
					get_node("Horse").play("blleft")
				"up":
					get_node("Horse").play("blup")
				"down":
					get_node("Horse").play("bldown")
		2:
			match movement:
				"right":
					get_node("Horse").play("brright")
				"left":
					get_node("Horse").play("brleft")
				"up":
					get_node("Horse").play("brup")
				"down":
					get_node("Horse").play("brdown")
		3:
			match movement:
				"right":
					get_node("Horse").play("goright")
				"left":
					get_node("Horse").play("goleft")
				"up":
					get_node("Horse").play("goup")
				"down":
					get_node("Horse").play("godown")
		4:
			match movement:
				"right":
					get_node("Horse").play("grright")
				"left":
					get_node("Horse").play("grleft")
				"up":
					get_node("Horse").play("grup")
				"down":
					get_node("Horse").play("grdown")
		5,_:
			match movement:
				"right":
					get_node("Horse").play("wright")
				"left":
					get_node("Horse").play("wleft")
				"up":
					get_node("Horse").play("wup")
				"down":
					get_node("Horse").play("wdown")
		
func update_target_position():
	which_way = rng.randi_range(1, 100)
	var target_vector = Vector2.ZERO
	if which_way % 2 == 0: #if arbitrary rng is even, go vertical
		target_vector = Vector2(global_position.x, rand_range(0, size.y))
	else:
		target_vector = Vector2(rand_range(0, size.x), global_position.y)
	target_position = start_position + target_vector

func is_at_target_position(): 
	# Stop moving when at target +/- tolerance
	return (target_position - global_position).length() < TOLERANCE

func _physics_process(delta):
	match state:
		IDLE:
			state = WANDER
			# Maybe wait for X seconds with a timer before moving on
			yield(get_tree().create_timer(0.05), "timeout")
			update_target_position()

		WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)
			if which_way % 2 == 0:
				if target_position.y <= global_position.y:
					lets_move("up")
				else:
					lets_move("down")
			else:
				if target_position.x >= global_position.x:
					lets_move("right")
				else:
					lets_move("left")

			if is_at_target_position():
				state = IDLE

	velocity = move_and_slide(velocity)

func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - global_position).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	velocity += acceleration_vector
	velocity = velocity.clamped(MAX_SPEED)
