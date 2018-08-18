extends "../platform_actor.gd"

export (String) var left = "left_1"
export (String) var right = "right_1"
export (String) var up = "up_1"
export (String) var down = "down_1"
export (String) var jump = "jump_1"
export (String) var dash = "dash_1"

func handle_input():
	pass

func _input(event):
	state_machine.state.input_process(self, event)