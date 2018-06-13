extends "state.gd"
var init_pos = Vector2()

func setup(actor):
	.setup(actor)
	init_pos = actor.position

func handle_input(actor, event):
	if event.is_action_released(actor.dash):
		if Input.is_action_pressed(actor.right) or Input.is_action_pressed(actor.left):
			actor.walk()
			return
		actor.stop()
	if event.is_action_pressed(actor.jump):
		actor.jump()
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
func process(actor, delta):
	actor.velocity.y = 0
	if actor.get_slide_count() > 0 and actor.is_on_floor():
		var c = actor.get_slide_collision(0)
		if abs(rad2deg(c.normal.angle())) > 90:
			actor.velocity = Vector2(actor.dash_speed * actor.direction, 
				actor.velocity.y)
	if actor.is_on_wall():
		if actor.is_on_floor():
			actor.stop()
		else:
			actor.wall_slide()
	var distance = abs(init_pos.x - actor.position.x)
	if distance > actor.dash_length:
		if !actor.has_method("handle_input"):
			actor.stop()
			return
		elif Input.is_action_pressed(actor.right) or Input.is_action_pressed(actor.left):
			if !actor.is_on_floor():
				actor.fall(true)
				return
			else:
				actor.walk()
				return
		actor.stop()