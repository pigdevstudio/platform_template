extends "res://modules/state_machine/state.gd"

func setup_state(kinematic_character):
	.setup_state(kinematic_character)
	wrapper.jumps = wrapper.max_jumps
	wrapper.velocity.x = wrapper.walk()

func _input(event):
	if event.is_action_released("left") and wrapper.direction == -1:
		wrapper.set_state(wrapper.IDLE)
	elif event.is_action_released("right") and wrapper.direction == 1:
		wrapper.set_state(wrapper.IDLE)
		
	if event.is_action_pressed("left"):
		wrapper.direction = -1
		wrapper.set_state(wrapper.WALK)
	elif event.is_action_pressed("right"):
		wrapper.direction = 1
		wrapper.set_state(wrapper.WALK)
		
	if event.is_action_pressed("jump"):
		wrapper.set_state(wrapper.JUMP)