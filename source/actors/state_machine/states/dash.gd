extends "state.gd"
export (int) var dash_length = 300
export (int) var dash_speed = 600

var can_dash = true
var init_pos = Vector2()

func setup(actor, previous_state):
	.setup(actor, previous_state)
	init_pos = actor.position
	if not can_dash:
		return
	actor.emit_signal("perform_action", "dash")
	actor.velocity.x = dash_speed * actor.direction
	can_dash = false

func input_process(actor, event):
	if event.is_action_released(actor.dash):
		actor.idle()
		can_dash = true
		
	if event.is_action_pressed(actor.jump):
		actor.jump()

func process(actor, delta):
	actor.velocity.y = 0
	if actor.is_on_wall():
		actor.wall_slide()
	
	if abs(init_pos.x - actor.position.x) >= dash_length:
		if actor.has_method("handle_input"):
			if Input.is_action_pressed(actor.right) or Input.is_action_pressed(actor.left):
				actor.walk()
			else:
				actor.idle()
		can_dash = true

	if not actor.is_on_floor():
		return
	if actor.get_slide_count() < 1:
		return
	
	var collision = actor.get_slide_collision(0)
	if abs(rad2deg(collision.normal.angle())) > 90:
		actor.velocity = Vector2(dash_speed * actor.direction, 0)	