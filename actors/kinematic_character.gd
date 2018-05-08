extends KinematicBody2D

enum states {IDLE, WALK, JUMP, FALL, DASH}
var state = IDLE setget set_state, get_state

export (int) var walk_speed = 100
export (int) var jump_height = 800
export (int) var dash_length = 500
export (int) var dash_speed = 600
export (int) var max_jumps = 2

var direction = 1
var velocity = Vector2(0, 0)
var can_dash = true

onready var in_jump_speed = walk_speed
onready var jumps = max_jumps

const GRAVITY = 80
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_STOP_SPEED = 400

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
		DASH:
			if can_dash:
				dash(state)
				can_dash = false
			else:
				set_state(state)
	emit_signal("state_changed", state, new_state)
	state = new_state
	
func get_state():
	return(state)
	
func jump():
	return(-jump_height)
	
func dash(previous_state):
	var init_pos = position
	while init_pos.distance_to(position) < dash_length:
		velocity.x = dash_speed * direction
		velocity.y = 0
		yield(get_tree(), "physics_frame")
		if get_state() != DASH:
			break
	if previous_state == JUMP:
		set_state(FALL)
		return
	set_state(previous_state)
	
func cancel_jump():
	velocity.y = 0
	
func walk(direction, speed):
	speed = speed * direction
	return(speed)
	
func stop():
	return(Vector2(0, velocity.y))
	
func _physics_process(delta):
	match state:
		IDLE:
			can_dash = is_on_floor()
		WALK:
			velocity.x = walk(direction, walk_speed)
			if velocity.y > 0:
				set_state(FALL)
			if is_on_wall():
				set_state(IDLE)
			can_dash = is_on_floor()
		JUMP:
			if velocity.y > 0:
				set_state(FALL)
		FALL:
			if is_on_floor():
				set_state(IDLE)
		DASH:
			if is_on_wall():
				set_state(IDLE)
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_STOP_SPEED, 4, deg2rad(46))
