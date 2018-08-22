extends "state.gd"

var in_air_speed = 400
export (float) var MAX_FALL_SPEED = 2000

func setup(actor, previous_state):
	.setup(actor, previous_state)

	actor.emit_signal("perform_action", "fall")

func input_process(actor, event):
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
		
	if event.is_action_pressed(actor.jump):
		actor.jump()
	
	if event.is_action_pressed(actor.dash):
		actor.dash()

func process(actor, delta):
	actor.velocity.y = min(actor.velocity.y, MAX_FALL_SPEED)
	
	if actor.is_on_wall():
		actor.wall_slide()
	
	if actor.has_method("handle_input"):
		if Input.is_action_pressed(actor.right):
			actor.direction = 1
			actor.velocity.x = in_air_speed * actor.direction
		elif Input.is_action_pressed(actor.left):
			actor.direction = -1
			actor.velocity.x = in_air_speed * actor.direction
	
	if actor.is_on_floor():
		if actor.has_method("handle_input"):
			if Input.is_action_pressed(actor.right):
				actor.direction = 1
				actor.walk()
			elif Input.is_action_pressed(actor.left):
				actor.direction = -1
				actor.walk()
			else:
				actor.idle()
		else:
			actor.idle()