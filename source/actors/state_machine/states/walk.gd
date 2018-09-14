extends "state.gd"

export (int) var speed = 400

func setup(actor, previous_state):
	actor.velocity.x = speed * actor.direction
	actor.emit_signal("action_performed", "walk")
	$coyotte_fall.connect("timeout", self, "_on_coyotte_fall_timeout", [actor])
	
func clear(actor):
	$coyotte_fall.disconnect("timeout", self, "_on_coyotte_fall_timeout")
	
func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		actor.jump()
	
	if event.is_action_pressed(actor.right):
		actor.direction = 1
	elif event.is_action_pressed(actor.left):
		actor.direction = -1

	if event.is_action_released(actor.right) and actor.direction == 1:
			if Input.is_action_pressed(actor.left):
				actor.direction = -1
			else:
				actor.idle()
	elif event.is_action_released(actor.left) and actor.direction == -1:
		if Input.is_action_pressed(actor.right):
			actor.direction = 1
		else:
			actor.idle()
			
	if event.is_action_pressed(actor.dash):
		actor.dash()

func process(actor, delta):
	actor.velocity.y += actor.GRAVITY

	if actor.velocity.y > actor.FALL_THRESHOLD:
		$coyotte_fall.start()
		
	if not $coyotte_fall.is_stopped() and actor.is_on_wall():
		actor.wall_slide()
	
	if actor.get_slide_count() < 1:
		return
	
	var collision = actor.get_slide_collision(0)
	if abs(rad2deg(collision.normal.angle())) > 90:
		actor.velocity = Vector2(speed * actor.direction, 0)
	
func _on_coyotte_fall_timeout(actor):
	actor.fall()
	