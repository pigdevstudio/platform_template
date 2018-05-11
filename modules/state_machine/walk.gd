extends "res://modules/state_machine/state.gd"

func setup_state(wrapper):
	wrapper.jumps = wrapper.max_jumps
	wrapper.velocity.x = wrapper.walk(wrapper.direction, wrapper.walk_speed)