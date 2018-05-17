extends Node

var state = null setget set_state, get_state
signal state_changed(from, to)

func set_state(new_state):
	new_state = get_node(new_state)
	if state != null:
		state.clear()
		emit_signal("state_changed", state, new_state)
		
	if new_state.name == "jump":
		if state.name == "dash":
			new_state.setup(get_parent(), get_parent().dash_speed)
		else:
			new_state.setup(get_parent(), get_parent().walk_speed)
	else:
		new_state.setup(get_parent())
	state = new_state
	
func get_state():
	return state