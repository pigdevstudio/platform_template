extends Node

export (NodePath) var actor = "../"
var previous_state = null
var state = null setget set_state, get_state
signal state_changed(from, to)

func _ready():
	actor = get_node(actor)

func set_state(new_state):
	new_state = get_node(new_state)
	
	if state != null:
		state.clear()
		emit_signal("state_changed", state.name, new_state.name)
		previous_state = state
	else:
		previous_state = new_state
	state = new_state
	state.setup(actor, previous_state.name)
	
func get_state():
	return state
	