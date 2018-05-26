extends "state.gd"

signal start_climb
signal stop_climb
func setup(actor):
	.setup(actor)
	actor.jumps = actor.max_jumps
func handle_input(actor, event):
	if event.is_action_pressed(actor.jump):
		actor.jump()

func process(actor, delta):
	if !actor.is_on_ladder():
		actor.fall()
		return
	if actor.has_method("handle_input"):
		if Input.is_action_pressed(actor.up):
			actor.velocity.y = -actor.climb_speed
			emit_signal("start_climb")
		elif Input.is_action_pressed(actor.down):
			actor.velocity.y = actor.climb_speed
			emit_signal("start_climb")
		else:
			actor.velocity.y = 0
			emit_signal("stop_climb")