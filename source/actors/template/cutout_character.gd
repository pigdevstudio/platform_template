extends Node2D
onready var initial_scale = get_scale()

enum directions {RIGHT, LEFT}

func flip_sprites(direction):
	if direction == RIGHT:
		scale.x = initial_scale.x
	else:
		scale.x = initial_scale.x * -1

func _on_actor_perform_action(action):
	match action:
		"idle":
			$animator.play("idle")
		"walk":
			$animator.play("walk")
		"jump":
			$animator.play("jump")
		"fall":
			$animator.play("fall")
		"dash":
			$animator.play("dash")
		"wall":
			$animator.play("wall")

func _on_actor_direction_changed(new_direction):
	if new_direction < 0:
		flip_sprites(LEFT)
	else:
		flip_sprites(RIGHT)