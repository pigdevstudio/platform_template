extends "state.gd"

var normal = Vector2(0,0)
var jump_length = 500
var jump_height = 500
signal wall_exited
signal wall_jumping
signal wall_entered
func setup(actor):
	.setup(actor)
	normal = actor.get_slide_collision(0).normal
	actor.jumps = actor.max_jumps
	actor.can_dash = true
	jump_length = actor.wall_jump_length
	jump_height = actor.jump_height
	if actor.has_method("handle_input"):
		if Input.is_action_pressed("dash"):
			jump_length = actor.wall_jump_length * 1.5
			jump_height = actor.jump_height * 1.5
			actor.can_dash = false
func handle_input(actor, event):
	if event.is_action_pressed("dash"):
		jump_length = actor.wall_jump_length * 1.5
		jump_height = actor.jump_height * 1.5
		actor.can_dash = false
	elif event.is_action_released("dash"):
		jump_length = actor.wall_jump_length
		jump_height = actor.jump_height
	if event.is_action_released("left"):
		actor.velocity.x = 10 * normal.x
		actor.fall()
	elif event.is_action_released("right"):
		actor.velocity.x = 10 * normal.x
		actor.fall()
	if event.is_action_pressed("jump"):
		if Input.is_action_pressed("right") and normal.x < 0:
			actor.wall_jump(jump_length * normal.x, jump_height)
		elif Input.is_action_pressed("left") and normal.x > 0:
			actor.wall_jump(jump_length * normal.x, jump_height)
		else:
			actor.jump()
			return
		actor.emit_signal("perform_action", "jump")
	if event.is_action_released("jump"):
		actor.cancel_jump()
func process(actor, delta):
	actor.velocity.x += actor.GRAVITY * -normal.x
	if actor.is_on_floor():
		actor.stop()
		return
	if !actor.is_on_wall():
		if (actor.velocity.x * -normal.x) > 100:
			actor.fall()
			return
		return
	actor.emit_signal("perform_action", "wall")
	actor.velocity.y = actor.velocity.y / 2
	
func clear():
#	actor.emit_signal("perform_action", "fall")
	pass