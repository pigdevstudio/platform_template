extends "state.gd"
export (int) var length = 300
export (int) var speed = 600

var init_pos = Vector2()

var can_dash = true

func setup(actor, previous_state):
	can_dash = true
	init_pos = actor.position
	
	match previous_state.name:
		"jump":
			if previous_state.jumps + 1 < previous_state.max_jumps:
				can_dash = false
			previous_state.jumps -= 1
		"fall":
			var jump = get_parent().get_node("jump")
			if jump.jumps + 1 < jump.max_jumps:
				can_dash = false
			jump.jumps -= 1
	
	if not can_dash:
		if previous_state.name == "jump":
			actor.fall()
		else:
			get_parent().state = previous_state.name
		return
	actor.velocity.y = 0
	
	actor.velocity.x = speed * actor.direction
	actor.emit_signal("action_performed", "dash")
	can_dash = false

func input_process(actor, event):
	if event.is_action_released(actor.dash):
		if actor.is_on_floor():
			actor.idle()
		else:
			actor.fall()
		
	if event.is_action_pressed(actor.jump):
		actor.jump()

func process(actor, delta):
	if actor.is_on_wall():
		actor.wall_slide()
	
	if abs(init_pos.x - actor.position.x) >= length:
		if actor.has_method("handle_input"):
			if Input.is_action_pressed(actor.right) or Input.is_action_pressed(actor.left):
				actor.walk()
			else:
				actor.idle()

	if not actor.is_on_floor():
		return
	if actor.get_slide_count() < 1:
		return
	
	var collision = actor.get_slide_collision(0)
	if abs(rad2deg(collision.normal.angle())) > 90:
		actor.velocity = Vector2(speed * actor.direction, 0)
	