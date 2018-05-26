extends "state.gd"

func handle_input(actor, event):
	if event.is_action_pressed(actor.right):
		actor.direction = 1
		actor.walk()
	elif event.is_action_pressed(actor.left):
		actor.direction = -1
		actor.walk()
	if event.is_action_pressed(actor.jump):
		actor.jump()
	if event.is_action_pressed(actor.dash):
		actor.dash()

func process(actor, delta):
	if actor.is_on_floor():
		actor.jumps = actor.max_jumps
		actor.can_dash = true
#	if actor.is_on_ladder():
#		if actor.has_method("handle_input"):
#			if Input.is_action_pressed("up"):
#				actor.climb_ladder()
#			elif Input.is_action_pressed("down"):
#				actor.climb_ladder()