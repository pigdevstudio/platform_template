extends Node

var state = self
var kinematic_character  = null

func set_state(new_state, wrapper):
	emit_signal("state_changed", state, new_state)
	state = new_state
	
func get_state():
	return(state)
	
func setup_state(wrapper):
	kinematic_character = wrapper
	if wrapper is load("res://actors/player_kinematic_character.gd"):
		set_process_input(true)