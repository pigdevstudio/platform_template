extends "state.gd"

func handle_input(actor, event):
	if event.is_action_released("right") and actor.direction == 1:
		if Input.is_action_pressed("left"):
			actor.direction = -1
			actor.walk()
			return
		actor.stop()
	if event.is_action_released("left") and actor.direction == -1:
		if Input.is_action_pressed("right"):
			actor.direction = 1
			actor.walk()
			return
		actor.stop()
	if event.is_action_pressed("left"):
		actor.direction = -1
		actor.walk()
	elif event.is_action_pressed("right"):
		actor.direction = 1
		actor.walk()

	if event.is_action_pressed("jump"):
		actor.jump()
	if event.is_action_pressed("dash"):
		actor.dash()

func process(actor, delta):
	if actor.is_on_floor():
		actor.jumps = actor.max_jumps
		actor.can_dash = true
	else:
		actor.fall()