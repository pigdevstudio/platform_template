extends Node

var state = null setget set_state, get_state
signal state_changed(from, to)

func set_state(new_state):
	new_state = get_node(new_state)
	emit_signal("state_changed", state, new_state)
	if state != null:
		state.clear()
	new_state.setup(get_parent())
	state = new_state
	
func get_state():
	return state