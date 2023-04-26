extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
enum {
	IDLE,
	WANDER
}

var size = OS.get_screen_size()
var prev_state = "none"


var velocity = Vector2.ZERO
var state = IDLE
var rng = RandomNumberGenerator.new()
var which_way = 0

const ACCELERATION = 800
const MAX_SPEED = 100
const TOLERANCE = 4.0

onready var start_position = global_position
onready var target_position = global_position

func _ready():
	randomize()
	size.x -= 300
	size.y -= 300

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
			state = WANDER #hi ian!
			# Maybe wait for X seconds with a timer before moving on
			yield(get_tree().create_timer(0.01), "timeout")
			update_target_position()

		WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)
			if which_way % 2 == 0:
				if target_position.y <= global_position.y:
					get_node("Horse").play("up")
				else:
					get_node("Horse").play("down")
			else:
				if target_position.x >= global_position.x:
					get_node("Horse").play("right")
					prev_state = "right"
				else:
					get_node("Horse").play("left")
					prev_state = "left"

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
