extends "res://modules/state_machine/states/state.gd"

var normal = Vector2(0,0)
var jump_length = 500
signal wall_finished
signal wall_jumping
signal is_on_wall
func setup(actor):
	.setup(actor)
	normal = actor.get_slide_collision(0).normal
	actor.jumps = actor.max_jumps
func handle_input(actor, event):
	if event.is_action_pressed("dash"):
		jump_length = 800
	elif event.is_action_released("dash"):
		jump_length = 500
	if event.is_action_released("left"):
		actor.velocity.x = 10 * normal.x
		actor.fall()
	elif event.is_action_released("right"):
		actor.velocity.x = 10 * normal.x
		actor.fall()
	if event.is_action_pressed("jump"):
		var height = actor.jump_height if Input.is_action_pressed("dash") else actor.jump_height * 2
		if Input.is_action_pressed("right") and normal.x < 0:
			actor.wall_jump(jump_length * normal.x)
		elif Input.is_action_pressed("left") and normal.x > 0:
			actor.wall_jump(jump_length * normal.x)
		else:
			actor.jump()
			return
		emit_signal("wall_jumping")
func process(actor, delta):
	actor.velocity.x += actor.GRAVITY * -normal.x
	if actor.is_on_floor():
		actor.stop()
		return
	if !actor.is_on_wall():
		return
	emit_signal("is_on_wall")
	actor.velocity.y = actor.velocity.y / 2
	
func clear():
	emit_signal("wall_finished")
	jump_length = 500