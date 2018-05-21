extends KinematicBody2D

export (int) var walk_speed = 100
export (int) var jump_height = 800
export (int) var wall_jump_length = 800
export (int) var max_jumps = 2
export (int) var dash_length = 300
export (int) var dash_speed = 200
export (int) var climb_speed = 200

var direction = 1
var velocity = Vector2(0, 0)
var can_dash = true

onready var in_jump_speed = walk_speed
onready var jumps = max_jumps
var state_machine = null

const GRAVITY = 50
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_STOP_SPEED = 200
const MAX_FALL_SPEED = 2000

signal enter_state(state)
signal perform_action(action)

func set_state(new_state):
	emit_signal("enter_state", new_state)
	emit_signal("perform_action", new_state)

func dash():
	if !can_dash or jumps < 1:
		return
	set_state("dash")
	var speed = (dash_speed * direction)
	velocity.x = speed
	can_dash = false
	jumps -= 1

func jump():
	if jumps > 0:
		set_state("jump")
		velocity.y = -jump_height
		jumps -= 1
		
func cancel_jump():
	velocity.y = 0
	
func fall():
	set_state("jump")
	emit_signal("perform_action", "fall")
	jumps -= 1
	
func walk():
	set_state("walk")
	var speed = walk_speed * direction
	velocity.x = speed
	
func stop():
	set_state("idle")
	velocity.x = 0
	
func wall_slide():
	set_state("wall")
	
func wall_jump(length = jump_height, height = jump_height):
	velocity.y = -height
	velocity.x = length
	
func climb_ladder():
	velocity.y = 0
	velocity.x = 0
	set_state("climb")

func is_on_ladder():
	return false
	
func _ready():
	state_machine = $state_machine
	connect("enter_state", state_machine, "set_state")
	set_state("idle")
	
func _physics_process(delta):
	velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_STOP_SPEED, 4, deg2rad(46))
	velocity.y = min(velocity.y, MAX_FALL_SPEED)
	velocity.y += GRAVITY
	if state_machine == null:
		return
	state_machine.state.process(self, delta)