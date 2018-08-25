extends KinematicBody2D

var direction = 1 setget set_direction
var velocity = Vector2(0, 0) setget set_velocity

var state_machine = null

export (float) var GRAVITY = 50
export (Vector2) var FLOOR_NORMAL = Vector2(0, -1)
export (float) var SLOPE_STOP_SPEED = 200
export (float) var SLOPE_MAX_DEGREE = 46
export (float) var FALL_THRESHOLD = 100

export (bool) var can_dash = true

signal enter_state(state)
signal perform_action(action)
signal direction_changed(new_direction)

func set_velocity(value):
	velocity = value

func set_direction(value):
	direction = value
	emit_signal("direction_changed", value)

func set_state(new_state):
	emit_signal("enter_state", new_state)

func dash():
	if not can_dash:
		return
	set_state("dash")

func jump():
	set_state("jump")
		
func cancel_jump():
	velocity.y = 0
	
func fall(force_fall = false):
	set_state("fall")
	emit_signal("perform_action", "fall")
	
func walk():
	set_state("walk")
	
func idle():
	set_state("idle")
	
func wall_slide():
	set_state("wall")
	
func _ready():
	state_machine = $state_machine
	connect("enter_state", state_machine, "set_state")
	set_state("idle")
	
func _physics_process(delta):
	velocity = move_and_slide(velocity, FLOOR_NORMAL, 
		SLOPE_STOP_SPEED, 4, deg2rad(SLOPE_MAX_DEGREE))
	state_machine.state.process(self, delta)
	