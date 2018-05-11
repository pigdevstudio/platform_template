extends Node

onready var states = get_children()

var state = null setget set_state, get_state
signal state_changed(from, to)

func _ready():
	if get_child_count() > 0:
		set_state(get_child(0))

func set_state(new_state):
	clear_state(state)
	new_state.setup_state(get_parent())
	emit_signal("state_changed", state, new_state)
	state = new_state
	
func get_state():
	return(state)
	
func clear_state(which):
	if which == null:
		return
	which.set_process_input(false)
	which.set_physics_process(false)