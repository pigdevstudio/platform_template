extends "res://modules/state_machine/states/state.gd"

func handle_input(actor, event):
	if event.is_action_released("right") or event.is_action_released("left"):
		actor.fall()
func process(actor, delta):
	actor.velocity.y = actor.velocity.y / 2
	if actor.is_on_floor():
		actor.stop()
	if !actor.is_on_wall():
		if !actor.has_method("handle_input"):
			actor.fall()
			return
	if Input.is_action_pressed("right"):
		actor.velocity.x = actor.walk_speed
		return
	elif Input.is_action_pressed("left"):
		actor.velocity.x = -actor.walk_speed
		return
	actor.fall()