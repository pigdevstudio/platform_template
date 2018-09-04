extends Area2D

func _on_pass_through_body_exited(body):
	if body.get_collision_layer_bit(3) and not get_parent().get_collision_mask_bit(3):
		get_parent().set_collision_mask_bit(3, true)
