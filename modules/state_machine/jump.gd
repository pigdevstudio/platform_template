extends "res://modules/state_machine/state.gd"

var previous_state = null

func setup_state(kinematic_character):
	.setup_state(kinematic_character)
	wrapper.velocity.y = wrapper.jump()
	wrapper.jumps -= 1

func _physics_process(delta):
	if wrapper.is_on_floor():
		wrapper.set_state(wrapper.IDLE)
		
func _input(event):
	if event.is_action_pressed("right"):
		wrapper.direction = 1
		wrapper.velocity.x = wrapper.walk()
	elif event.is_action_pressed("left"):
		wrapper.direction = -1
		wrapper.velocity.x = wrapper.walk()
	if event.is_action_released("right") and wrapper.direction == 1:
		wrapper.velocity.x = 0
	elif event.is_action_released("left") and wrapper.direction == -1:
		wrapper.velocity.x = 0
	if event.is_action_pressed("jump"):
		wrapper.set_state(wrapper.JUMP)