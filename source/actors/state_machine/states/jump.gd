extends "state.gd"

export (int) var jump_height = 800
export (int) var max_jumps = 2

var was_dashing = false
var in_air_speed = 400.0

onready var jumps = max_jumps setget set_jumps

func setup(actor, previous_state):
	was_dashing = false
	in_air_speed = get_node("../walk").speed
	
	match previous_state.name:
		"idle":
			jumps = max_jumps
		"walk":
			jumps = max_jumps
		"fall":
			jumps = min(jumps, max_jumps - 1)
		"dash":
			in_air_speed = previous_state.speed
			jumps = max(max_jumps - 1, 1)
			was_dashing = true
	
	if jumps < 1:
		return
	
	jumps -= 1
	actor.velocity.y = -jump_height
	actor.emit_signal("action_performed", "jump")

func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		actor.jump()
	elif event.is_action_released(actor.jump):
		actor.cancel_jump()
		
	if event.is_action_pressed(actor.right):
		actor.direction = 1
		actor.velocity.x = in_air_speed * actor.direction
	elif event.is_action_pressed(actor.left):
		actor.direction = -1
		actor.velocity.x = in_air_speed * actor.direction
	if event.is_action_released(actor.right):
		actor.direction = 1
		actor.velocity.x = 0
	elif event.is_action_released(actor.left):
		actor.direction = -1
		actor.velocity.x = 0
	
	if event.is_action_pressed(actor.dash) and jumps >= max_jumps - 1:
		if not was_dashing:
			actor.dash()
	if event.is_action_released(actor.dash):
		in_air_speed = get_node("../walk").speed

func process(actor, delta):
	actor.velocity.y += actor.GRAVITY
	if actor.velocity.y > actor.FALL_THRESHOLD:
		actor.fall()
	if actor.is_on_wall():
		actor.wall_slide()
	
	if not actor.has_method("handle_input"):
		return
	if Input.is_action_pressed(actor.right):
		actor.direction = 1
		actor.velocity.x = in_air_speed * actor.direction
	elif Input.is_action_pressed(actor.left):
		actor.direction = -1
		actor.velocity.x = in_air_speed * actor.direction
	
func set_jumps(value):
	jumps = value
	jumps = clamp(jumps, 0, max_jumps)
