extends "res://actors/kinematic_character.gd"

func handle_input():
	pass
func _input(event):
	state_machine.get_state().handle_input(self, event)