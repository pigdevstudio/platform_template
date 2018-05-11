extends "res://modules/state_machine/state.gd"

func setup_state(wrapper):
	wrapper.jumps = wrapper.max_jumps
	wrapper.velocity.x = 0
	
func _input(event):
	print(event)