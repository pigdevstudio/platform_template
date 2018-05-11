extends "res://modules/state_machine/state.gd"

var previous_state = null

func setup_state(wrapper):
	wrapper.velocity.y = wrapper.jump()
	wrapper.jumps -= 1
	kinematic_character = wrapper
	set_physics_process(true)
