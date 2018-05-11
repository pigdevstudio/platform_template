extends KinematicBody2D

export (int) var walk_speed = 100
export (int) var jump_height = 800
export (int) var max_jumps = 2

var direction = 1
var velocity = Vector2(0, 0)

onready var in_jump_speed = walk_speed
onready var jumps = max_jumps
onready var state_machine = $state_machine

const GRAVITY = 80
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_STOP_SPEED = 200

enum states {IDLE, WALK, JUMP, FALL}

func set_state(new_state):
	state_machine.set_state(state_machine.states[new_state])

func jump():
	if jumps > 0:
		return(-jump_height)
	else:
		return(velocity.y)
	
func cancel_jump():
	velocity.y = 0
	
func walk():
	var speed = walk_speed * direction
	return(speed)
	
func stop():
	return(Vector2(0, velocity.y))
	
func _physics_process(delta):
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_STOP_SPEED, 4, deg2rad(46))
