extends Node

var previous_state = null
var state = null setget set_state, get_state
signal state_changed(from, to)

func set_state(new_state):
	new_state = get_node(new_state)
	
	if state != null:
		state.clear()
		emit_signal("state_changed", state, new_state)
		state_transition(state, new_state)
	
	new_state.setup(get_parent())
	previous_state = state
	state = new_state
	
func get_state():
	return state
	
func state_transition(from, to):
	match from.name:
		"fall":
			if to.name == "idle" or to.name == "walk":
				$jump.jumps = $jump.max_jumps
				$dash.can_dash = true
		"dash":
			if to.name == "jump":
				$jump.in_air_speed = $dash.dash_speed
				
		"walk":
			if to.name == "jump":
				$jump.in_air_speed = $walk.walk_speed
	
	match to.name:
		"fall":
			if from.name == "jump":
				$fall.in_air_speed = $jump.in_air_speed