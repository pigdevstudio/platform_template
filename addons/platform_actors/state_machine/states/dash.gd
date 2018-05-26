extends "state.gd"
var init_pos = Vector2()
signal drifting

func setup(actor):
	.setup(actor)
	init_pos = actor.position

func handle_input(actor, event):
	if event.is_action_released(actor.dash):
		emit_signal("drifting")
		if Input.is_action_pressed(actor.right) or Input.is_action_pressed(actor.left):
			actor.walk()
			return
		actor.stop()
	if event.is_action_pressed(actor.jump):
		actor.jump()
	if event.is_action_released(actor.right) and actor.direction == 1:
		emit_signal("drifting")
		if Input.is_action_pressed(actor.left):
			actor.direction = -1
			actor.walk()
			return
		actor.stop()
	if event.is_action_released(actor.left) and actor.direction == -1:
		emit_signal("drifting")
		if Input.is_action_pressed(actor.right):
			actor.direction = 1
			actor.walk()
			return
		actor.stop()
	if event.is_action_pressed(actor.left):
		actor.direction = -1
		actor.walk()
	elif event.is_action_pressed(actor.right):
		actor.direction = 1
		actor.walk()
func process(actor, delta):
	actor.velocity.y = 0
	if actor.is_on_wall():
		if actor.is_on_floor():
			actor.stop()
		else:
			actor.wall_slide()
	if abs(init_pos.x - actor.position.x) > actor.dash_length:
		if !actor.has_method("handle_input"):
			actor.stop()
			return
		elif Input.is_action_pressed(actor.right) or Input.is_action_pressed(actor.left):
			if !actor.is_on_floor():
				actor.fall()
				return
			else:
				actor.walk()
				emit_signal("drifting")
				return
		emit_signal("drifting")
		actor.stop()