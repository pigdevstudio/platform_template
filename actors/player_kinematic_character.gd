extends "res://actors/kinematic_character.gd"

<<<<<<< HEAD
func handle_input():
	pass
=======
func _input(event):
	match state:
		IDLE:
			if event.is_action_pressed("right") :
				direction = 1
				set_state(WALK)
			elif event.is_action_pressed("left") :
				direction = -1
				set_state(WALK)
			if event.is_action_pressed("jump"):
				set_state(JUMP)
			if event.is_action_pressed("dash"):
				set_state(DASH)
		WALK:
			if event.is_action_pressed("right") :
				direction = 1
			elif event.is_action_pressed("left") :
				direction = -1
			elif event.is_action_released("right") and direction == 1:
				set_state(IDLE)
			elif event.is_action_released("left") and direction == -1:
				set_state(IDLE)
			if event.is_action_pressed("jump"):
				set_state(JUMP)
			if event.is_action_pressed("dash"):
				set_state(DASH)

		JUMP:
			if event.is_action_pressed("right") :
				direction = 1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_pressed("left") :
				direction = -1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_released("right") and direction == 1:
				velocity = stop()
			elif event.is_action_released("left") and direction == -1:
				velocity = stop()
			if event.is_action_released("jump"):
				cancel_jump()
			if event.is_action_pressed("dash"):
				set_state(DASH)
		FALL:
			if event.is_action_pressed("right"):
				direction = 1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_pressed("left") :
				direction = -1
				velocity.x = walk(direction, in_jump_speed)
			elif event.is_action_released("right") and direction == 1:
				velocity = stop()
			elif event.is_action_released("left") and direction == -1:
				velocity = stop()
			if event.is_action_pressed("jump") and jumps > 0:
				set_state(JUMP)
			if event.is_action_pressed("dash"):
				set_state(DASH)
				
		DASH:
			if event.is_action_released("dash"):
				set_state(IDLE)
			if event.is_action_released("left"):
				direction = -1
				set_state(WALK)
			if event.is_action_released("right"):
				direction = 1
				set_state(WALK)
				
				
func _physics_process(delta):
	match state:
		FALL:
			if is_on_floor():
				if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
					set_state(WALK)
>>>>>>> parent of 12030e9... Fixed #5
