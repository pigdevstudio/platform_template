extends Node2D

export (float) var final_scale = Vector2(1.5, 1.5)
export (float) var float_length = 100
export (float) var duration = 0.25
func _ready():
	pop()
	
func pop():
	$tween.interpolate_property(self, "scale", scale, final_scale, duration,
		Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$tween.start()
	yield($tween, "tween_completed")
	$tween.interpolate_property(self, "position", position, 
		position - Vector2(0, float_length), duration, Tween.TRANS_BACK, 
		Tween.EASE_IN)
	$tween.interpolate_property(self, "modulate", modulate, Color(1, 1, 1, 0),
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$tween.start()
	yield($tween, "tween_completed")
	queue_free()