extends Node

var state = self
var wrapper = null

func _ready():
	set_process_input(false)
	set_physics_process(false)

func set_state(new_state):
	emit_signal("state_changed", state, new_state)
	state = new_state

func get_state():
	return(state)
	
func setup_state(kinematic_character):
	set_physics_process(true)
	if kinematic_character.has_method("handle_input"):
		set_process_input(true)
	wrapper = kinematic_character