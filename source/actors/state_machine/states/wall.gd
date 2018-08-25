extends "state.gd"

export (float) var wall_jump = 800
export (float) var dash_jump_multiplier = 1.4
export (float) var MAX_WALL_SPEED = 600

var normal = Vector2(0,0)

func setup(actor, previous_state):
	normal = actor.get_slide_collision(0).normal
	actor.emit_signal("perform_action", "wall")

func input_process(actor, event):
	if event.is_action_pressed(actor.jump) and actor.is_on_wall():
		if Input.is_action_pressed(actor.dash):
			actor.velocity.x = (wall_jump * normal.x)
			actor.velocity.y = -wall_jump * dash_jump_multiplier
			actor.emit_signal("perform_action", "jump")
		else:
			actor.velocity.x = wall_jump * normal.x
			actor.velocity.y = -wall_jump
			actor.emit_signal("perform_action", "jump")
	
	elif event.is_action_pressed(actor.dash) and not actor.is_on_wall():
		actor.dash()
	
	if event.is_action_released(actor.right) and sign(normal.x) == -1:
		actor.velocity.x = 0
		actor.fall()
	if event.is_action_released(actor.left) and sign(normal.x) == 1:
		actor.velocity.x = 0
		actor.fall()
		

func process(actor, delta):
	if actor.is_on_wall():
		actor.emit_signal("perform_action", "wall")
		actor.velocity.y /= 2
	elif actor.velocity.y > actor.FALL_THRESHOLD:
		actor.fall()
	actor.velocity.y += actor.GRAVITY
	
	if actor.is_on_floor():
		if not actor.has_method("handle_input"):
			actor.idle()
			return
		if Input.is_action_pressed(actor.right) or Input.is_action_pressed(actor.left):
			actor.walk()
		else:
			actor.idle()
	
	if actor.has_method("handle_input"):
		if Input.is_action_pressed(actor.right) and sign(normal.x) == -1:
			actor.velocity.x += actor.GRAVITY * -sign(normal.x) * 2
		elif Input.is_action_pressed(actor.left) and sign(normal.x) == 1:
			actor.velocity.x += actor.GRAVITY * -sign(normal.x) * 2
	else:
		actor.velocity.x += actor.GRAVITY * -sign(normal.x) * 2
	
	actor.velocity.x = clamp(actor.velocity.x, -MAX_WALL_SPEED, MAX_WALL_SPEED)
	