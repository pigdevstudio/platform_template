extends "state.gd"

var in_jump_speed = 100 setget set_in_jump_speed

func setup(actor, speed):
	.setup(actor)
	set_in_jump_speed(speed)

func set_in_jump_speed(value):
	in_jump_speed = value
func handle_input(actor, event):
	if event.is_action_pressed(actor.right):
		actor.direction = 1
		actor.velocity.x = in_jump_speed * actor.direction
	elif event.is_action_pressed(actor.left):
		actor.direction = -1
		actor.velocity.x = in_jump_speed * actor.direction
	if event.is_action_released(actor.right) or event.is_action_released(actor.left):
		actor.velocity.x = 0
	if event.is_action_pressed(actor.jump):
		actor.jump()
	elif event.is_action_released(actor.jump) and actor.velocity.y < 0:
		actor.cancel_jump()
	if event.is_action_pressed(actor.dash):
		actor.dash()

func process(actor, delta):
	if actor.is_on_wall():
		actor.wall_slide()
		return
	if !actor.is_on_floor() and actor.velocity.y > actor.FALL_THRESHOLD:
		actor.emit_signal("perform_action", "fall")
	if actor.is_on_floor():
		actor.stop()
	if !actor.has_method("handle_input"):
		return
	if Input.is_action_pressed(actor.right) or Input.is_action_pressed(actor.left):
		if actor.is_on_floor():
			actor.walk()
			return
	if Input.is_action_pressed(actor.right):
		actor.direction = 1
		actor.velocity.x = in_jump_speed * actor.direction
	elif Input.is_action_pressed(actor.left):
		actor.direction = -1
		actor.velocity.x = in_jump_speed * actor.direction
