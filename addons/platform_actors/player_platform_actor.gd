extends "platform_actor.gd"

export (String) var left = "left"
export (String) var right = "right"
export (String) var up = "up"
export (String) var down = "down"
export (String) var jump = "jump"
export (String) var dash = "dash"
func handle_input():
	pass
func _input(event):
	state_machine.state.handle_input(self, event)