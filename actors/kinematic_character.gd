extends KinematicBody2D

export (int) var walk_speed = 100
export (int) var jump_height = 800
export (int) var max_jumps = 2
export (int) var dash_length

var direction = 1
var velocity = Vector2(0, 0)

onready var in_jump_speed = walk_speed
onready var jumps = max_jumps
onready var state_machine = $state_machine

const GRAVITY = 80
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_STOP_SPEED = 200

func set_state(new_state):
	state_machine.push_state(new_state)
	state_machine.resolve_states()

func dash():
	set_state("dash")
	var speed = (walk_speed * direction) * 3
	velocity.x = speed

func jump():
	if jumps > 0:
		set_state("jump")
		velocity.y = -jump_height
		jumps -= 1

func fall():
	set_state("fall")

func cancel_jump():
	velocity.y = 0
	fall()

func walk():
	set_state("walk")
	var speed = walk_speed * direction
	velocity.x = speed

func stop():
	velocity.x = 0

func _ready():
	set_state("idle")

func _physics_process(delta):
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR_NORMAL, SLOPE_STOP_SPEED, 4, deg2rad(46))
	if is_on_floor():
		jumps = max_jumps
