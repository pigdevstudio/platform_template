extends "platform_actor.gd"

func handle_input():
	pass
func _input(event):
	state_machine.state.handle_input(self, event)