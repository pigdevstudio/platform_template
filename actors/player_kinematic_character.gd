extends "res://actors/platform_character/kinematic_character.gd"

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
		FALL:
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
			if event.is_action_pressed("jump"):
				set_state(JUMP)
				
func _physics_process(delta):
	match state:
		FALL:
			if is_on_floor():
				if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
					set_state(WALK)