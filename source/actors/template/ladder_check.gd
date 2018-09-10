extends Area2D

export (bool) var snap = false

onready var actor = get_parent()
var is_on_ladder = false

func _input(event):
	if event.is_action_pressed(actor.down) or event.is_action_pressed(actor.up):
		if not is_on_ladder:
			return
		actor.set_collision_mask_bit(2, false)
		actor.climb()
		if not snap:
			return
		#Searches for an area to snap to
		var area = null
		for a in get_overlapping_areas():
			if not a.get_collision_layer_bit(2):
				continue
			area = a
		actor.global_position.x = area.global_position.x

func _on_ladder_check_body_entered(body):
	if body.get_collision_layer_bit(2):
		is_on_ladder = true

func _on_ladder_check_area_entered(area):
	if area.get_collision_layer_bit(2):
		is_on_ladder = true

func _on_ladder_check_area_exited(area):
	if area.get_collision_layer_bit(2):
		is_on_ladder = false
		actor.set_collision_mask_bit(2, true)
		actor.fall()
