extends GraphNode

func _ready():
	$option_button.selected = 0
	setup_input_options()
	
func _on_option_button_item_selected(ID):
	match ID:
		0:
			setup_input_options()
			

func setup_input_options():
	for action in InputMap.get_actions():
		if "ui" in action:
			continue
		print(action)