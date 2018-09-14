extends "state.gd"

export (float) var speed = 200

var direction = Vector2(0, -1)

func setup(actor, previous_state):
	actor.velocity = Vector2(0, 0)
	actor.emit_signal("action_performed", "climb")

func input_process(actor, event):
	if event.is_action_pressed(actor.up):
		direction.y = -1
		actor.emit_signal("action_performed", "climb")
	elif event.is_action_pressed(actor.down):
		direction.y = 1
		actor.emit_signal("action_performed", "climb")
	elif event.is_action_pressed(actor.left):
		direction.x = -1
		actor.emit_signal("action_performed", "climb")
	elif event.is_action_pressed(actor.right):
		direction.x = 1
		actor.emit_signal("action_performed", "climb")
		
	if event.is_action_released(actor.up) and direction.y == -1:
		actor.velocity.y = 0
		actor.emit_signal("action_performed", "stop")
	elif event.is_action_released(actor.down) and direction.y == 1:
		actor.velocity.y = 0
		actor.emit_signal("action_performed", "stop")
	elif event.is_action_released(actor.left) and direction.x == -1:
		actor.velocity.x = 0
		actor.emit_signal("action_performed", "stop")
	elif event.is_action_released(actor.right) and direction.x == 1:
		actor.velocity.x = 0
		actor.emit_signal("action_performed", "stop")
		
	if event.is_action_pressed(actor.jump):
		actor.jump()
	
func process(actor, delta):
	
	if actor.is_on_floor():
		actor.idle()
		
	if not actor.has_method("handle_input"):
		return
		
	if Input.is_action_pressed(actor.up):
		direction.y = -1
		actor.velocity.y = -speed
	elif Input.is_action_pressed(actor.down):
		direction.y = 1
		actor.velocity.y = speed
	elif Input.is_action_pressed(actor.left):
		direction.x = -1
		actor.velocity.x = -speed 
	elif Input.is_action_pressed(actor.right):
		direction.x = 1
		actor.velocity.x = speed
