extends "state.gd"

export (int) var wall_jump = 800

var normal = Vector2(0,0)

func setup(actor):
	.setup(actor)
	
	normal = actor.get_slide_collision(0).normal
	actor.emit_signal("perform_action", "wall")

func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		if Input.is_action_pressed(actor.right) and sign(normal.x) == -1:
			actor.velocity.x += wall_jump * -1
			actor.velocity.y = -wall_jump
		elif Input.is_action_pressed(actor.left) and sign(normal.x) == 1:
			actor.velocity.x += wall_jump
			actor.velocity.y = -wall_jump
		else:
			actor.jump()
		actor.emit_signal("perform_action", "jump")
	
	if event.is_action_released(actor.right) and sign(normal.x) == -1:
		actor.fall()
	if event.is_action_released(actor.left) and sign(normal.x) == 1:
		actor.fall()

func process(actor, delta):
	actor.velocity.x += actor.GRAVITY * -sign(normal.x)
	if actor.is_on_wall():
		actor.velocity.y /= 2