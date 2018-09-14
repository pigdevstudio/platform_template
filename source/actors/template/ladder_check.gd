extends Area2D

export (bool) var snap = false

onready var actor = get_parent()
var is_on_ladder = false
var already_snap = false
var center = null

func _input(event):
	if not is_on_ladder:
		return
	if event.is_action_pressed(actor.down) or event.is_action_pressed(actor.up):
		actor.set_collision_mask_bit(2, false)
		actor.climb()
		if not snap or already_snap:
			return
		#Searches for an area to snap to
		actor.global_position.x = center
		already_snap = true

func _on_ladder_check_body_entered(body):
	is_on_ladder = true
	center = body.global_position.x

func _on_ladder_check_area_entered(area):
	is_on_ladder = true
	center = area.global_position.x

func _on_ladder_check_area_exited(area):
	is_on_ladder = false
	already_snap = false
	actor.set_collision_mask_bit(2, true)
	actor.fall()
