extends KinematicBody2D

export (int) var walk_speed = 100
export (int) var jump_height = 800
export (int) var max_jumps = 2
export (int) var dash_length = 300
export (int) var dash_speed = 200

var direction = 1
var velocity = Vector2(0, 0)
var can_dash = true

onready var in_jump_speed = walk_speed
onready var jumps = max_jumps
onready var state_machine = $state_machine

const GRAVITY = 80
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_STOP_SPEED = 100

signal falling

func set_state(new_state):
	state_machine.set_state(new_state)

func dash():
	if !can_dash or jumps < 1:
		return
	set_state("dash")
	var speed = (dash_speed * direction)
	velocity.x = speed
	can_dash = false

func jump():
	if jumps > 0:
		set_state("jump")
		velocity.y = -jump_height
		jumps -= 1

func fall():
	emit_signal("falling")

func cancel_jump():
	velocity.y = 0

func walk():
	set_state("walk")
	var speed = walk_speed * direction
	velocity.x = speed

func stop():
	set_state("idle")
	velocity.x = 0

func _ready():
	set_state("idle")

func _physics_process(delta):
	velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_STOP_SPEED, 4, deg2rad(46))
	velocity.y += GRAVITY
	state_machine.state.process(self, delta)