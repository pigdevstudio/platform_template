extends Area2D

export (GDScript) var Player
var player = null
var player_bits

func _ready():
	set_process(false)
	set_process_input(false)

func _on_ladder_body_entered(body):
	if not body is Player:
		return
	player = body
	player_bits = player.get_collision_mask()
	set_process(true)
	
func _process(delta):
	if not player in get_overlapping_bodies():
		return
	if Input.is_action_pressed(player.up) or Input.is_action_pressed(player.down):
		player.climb()
		player.global_position.x = global_position.x
		player.set_collision_mask(get_collision_layer())
		set_process(false)

func _on_ladder_body_exited(body):
	if not body is Player:
		return
	player.set_collision_mask(player_bits)
	player.fall()
	player = null
	set_process(false)
