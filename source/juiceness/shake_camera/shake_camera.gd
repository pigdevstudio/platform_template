extends Camera2D

export (float) var shake_strength = 10


func _ready():
	set_process(false)

func _process(delta):
	position.x = rand_range(-shake_strength, shake_strength)
	position.y = rand_range(-shake_strength, shake_strength)

func shake(strength = shake_strength, time = $timer.wait_time):
	
	var initial_pos = position
	var drag_h = drag_margin_h_enabled
	var drag_v = drag_margin_v_enabled
	drag_margin_h_enabled = false
	drag_margin_v_enabled = false
	var default_time = $timer.wait_time
	var default_strength = shake_strength

	shake_strength = strength
	$timer.wait_time = time

	set_process(true)
	$timer.start()
	yield($timer, "timeout")

	set_process(false)
	position = initial_pos
	drag_margin_h_enabled = drag_h
	drag_margin_v_enabled = drag_v
	shake_strength = default_strength
	$timer.wait_time = default_time
	