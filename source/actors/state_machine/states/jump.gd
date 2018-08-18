extends "state.gd"

var in_air_speed = 400.0
export (int) var jump_height = 800
export (int) var max_jumps = 2

onready var jumps = max_jumps

func setup(actor):
	.setup(actor)
	jumps -= 1
	actor.emit_signal("perform_action", "jump")
	if jumps < 1:
		return
	actor.velocity.y = -jump_height

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
		actor.dash()

func process(actor, delta):
	if actor.is_on_floor():
		jumps = max_jumps
	
	if not actor.has_method("handle_input"):
		return
	if Input.is_action_pressed(actor.right):
		actor.direction = 1
		actor.velocity.x = in_air_speed * actor.direction
	elif Input.is_action_pressed(actor.left):
		actor.direction = -1
		actor.velocity.x = in_air_speed * actor.direction