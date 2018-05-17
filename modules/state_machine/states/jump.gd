extends "state.gd"
signal falling

var in_jump_speed = 100 setget set_in_jump_speed

func setup(actor, speed):
	.setup(actor)
	set_in_jump_speed(speed)

func set_in_jump_speed(value):
	in_jump_speed = value
func handle_input(actor, event):
	if event.is_action_pressed("right"):
		actor.direction = 1
		actor.velocity.x = in_jump_speed * actor.direction
	elif event.is_action_pressed("left"):
		actor.direction = -1
		actor.velocity.x = in_jump_speed * actor.direction
	if event.is_action_released("right") or event.is_action_released("left"):
		actor.velocity.x = 0
	if event.is_action_pressed("jump"):
		actor.jump()
	elif event.is_action_released("jump") and actor.velocity.y < 0:
		actor.cancel_jump()
	if event.is_action_pressed("dash"):
		actor.dash()

func process(actor, delta):
	if actor.is_on_floor():
		if !actor.has_method("handle_input"):
			actor.stop()
			return
		if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
			actor.walk()
			return
		actor.stop()
	if !actor.is_on_floor() and actor.velocity.y > 0:
		emit_signal("falling")
	if Input.is_action_pressed("right"):
		actor.direction = 1
		actor.velocity.x = in_jump_speed * actor.direction
	elif Input.is_action_pressed("left"):
		actor.direction = -1
		actor.velocity.x = in_jump_speed * actor.direction
	if actor.is_on_wall():
		actor.wall_slide()
		return