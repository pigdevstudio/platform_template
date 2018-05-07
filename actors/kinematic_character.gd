extends KinematicBody2D

enum states {IDLE, WALK, JUMP, FALL}
var state = IDLE setget set_state, get_state

export (int) var walk_speed = 100
export (int) var jump_height = 800

var direction = 0

onready var in_jump_speed = walk_speed

const GRAVITY = 100
const FLOOR_NORMAL = Vector2(0, -1)

var velocity = Vector2(0, 0)
export (int) var max_jumps = 2
onready var jumps = max_jumps

signal state_changed(from, to)
func set_state(new_state):
	if state == new_state:
		return
	match new_state:
		IDLE:
			jumps = max_jumps
			velocity = Vector2(0,0)
		WALK:
			jumps = max_jumps
		JUMP:
			if jumps > 0:
				velocity.y = jump() if jumps == max_jumps else jump() * 1.15
				jumps -= 1
		FALL:
			pass
	emit_signal("state_changed", state, new_state)
	state = new_state
	
func get_state():
	return(state)
	
func jump():
	return(-jump_height)
	
func cancel_jump():
	velocity.y = 0
	
func walk(direction, speed):
	speed = speed * direction
	return(speed)
	
func stop():
	direction = 0
	return(Vector2(0, velocity.y))
	
func _physics_process(delta):
	match state:
		IDLE:
			pass
		WALK:
			velocity.x = walk(direction, walk_speed)
			if velocity.y > 0:
				set_state(FALL)
		JUMP:
			if velocity.y > 0:
				set_state(FALL)
		FALL:
			if is_on_floor():
				set_state(IDLE)
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR_NORMAL, 0)