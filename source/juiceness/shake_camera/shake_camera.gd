extends Camera2D

export (float) var shake_strength = 10


func _ready():
	set_process(false)

func _process(delta):
	offset.x = rand_range(-shake_strength, shake_strength)
	offset.y = rand_range(-shake_strength, shake_strength)

func shake(strength = shake_strength, time = $timer.wait_time):
	
	var default_time = $timer.wait_time
	var default_strength = shake_strength

	shake_strength = strength
	$timer.wait_time = time

	set_process(true)
	$timer.start()
	yield($timer, "timeout")

	set_process(false)
	offset = Vector2(0, 0)
	shake_strength = default_strength
	$timer.wait_time = default_time
