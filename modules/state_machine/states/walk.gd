extends 'state.gd'

func handle_input(actor, event):
	if event.is_action_released("right") and actor.direction == 1:
		actor.stop()
	elif event.is_action_released("left") and actor.direction == -1:
		actor.stop()

	if event.is_action_pressed("jump"):
		actor.jump()
	if event.is_action_pressed("dash"):
		actor.dash()

func process(actor, delta):
	if actor.is_on_floor():
		actor.jumps = actor.max_jumps
		actor.can_dash = true