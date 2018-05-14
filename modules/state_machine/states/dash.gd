extends "state.gd"
var init_pos = Vector2()

func setup(actor):
	.setup(actor)
	init_pos = actor.position

func handle_input(actor, event):
	if event.is_action_released("dash"):
		if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
			actor.walk()
			return
		actor.stop()
	if event.is_action_pressed("jump"):
		actor.jump()
func process(actor, delta):
	actor.velocity.y = 0
	if abs(init_pos.x - actor.position.x) > actor.dash_length:
		if !actor.has_method("handle_input"):
			actor.stop()
			return
		elif Input.is_action_pressed("right") or Input.is_action_pressed("left"):
			if !actor.is_on_floor():
				actor.set_state("jump")
				return
			else:
				actor.walk()
				return
		actor.stop()