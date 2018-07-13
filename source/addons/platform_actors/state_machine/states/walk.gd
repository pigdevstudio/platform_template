extends "state.gd"

func handle_input(actor, event):
	if event.is_action_released(actor.right) and actor.direction == 1:
		if Input.is_action_pressed(actor.left):
			actor.direction = -1
			actor.walk()
			return
		actor.stop()
	if event.is_action_released(actor.left) and actor.direction == -1:
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

	if event.is_action_pressed(actor.jump):
		actor.jump()
	if event.is_action_pressed(actor.dash):
		actor.dash()

func process(actor, delta):
	if actor.is_on_floor():
		if actor.get_slide_count() > 0:
			var c = actor.get_slide_collision(0)
			if abs(rad2deg(c.normal.angle())) > 90:
				actor.velocity = Vector2(actor.walk_speed * actor.direction, 
					0)
		actor.jumps = actor.max_jumps
		actor.can_dash = true
	else:
		actor.fall()