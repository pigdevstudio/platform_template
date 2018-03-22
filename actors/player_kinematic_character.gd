extends "./basic_kinematic_character.gd"


func _input(event):

	match get_state():
		IDLE:
			