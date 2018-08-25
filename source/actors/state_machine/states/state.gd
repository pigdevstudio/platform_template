extends Node

func _ready():
	set_process_input(false)
	set_process(false)
	set_physics_process(false)
	
func process(actor, delta):
	pass
	
func input_process(actor, event):
	pass
	
func setup(actor, previous_state):
	pass
	
func clear():
	pass
	