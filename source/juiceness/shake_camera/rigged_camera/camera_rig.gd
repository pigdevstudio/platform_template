extends RemoteTransform2D

var camera = null

func _ready():
	camera = get_node(remote_path)

func shake(strength = camera.shake_strength, 
	time = camera.get_node("timer").wait_time):
	camera.shake(strength, time)
