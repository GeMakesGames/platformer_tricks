extends CharacterBody2D
class_name Player

const ACCELERATION = 1000.0
const MAX_SPEED = 90.0
const JUMP_SPEED = -300.0

const GRAVITY = 900
const FALL_GRAVITY = 450
const TERMINAL_VELOCITY = 180

const AIR_MULTIPLIER = 0.5

@onready var fsm = $FSM
@onready var ap = $AnimationPlayer
@onready var s = $Sprite2D
@onready var jump_buffer_timer = $JumpBufferTimer

func _ready():
	fsm.change_state("idle")

func _physics_process(delta):
	if get_jump_input():
		jump_buffer_timer.start()
	sync_direction()
	fsm.physics_update(delta)

func sync_direction():
	var input_x = get_input_x()
	if input_x == 0: return
	s.flip_h = input_x == -1

func update_velocity(delta):
	velocity.y = move_toward(velocity.y, TERMINAL_VELOCITY, (GRAVITY if fsm.current_state == "jump" else FALL_GRAVITY) * delta)
	velocity.x = move_toward(velocity.x, get_input_x() * MAX_SPEED, (1 if is_on_floor() else AIR_MULTIPLIER) * ACCELERATION * delta)
	print("player velocity: %s" % velocity)

func play(anim):
	ap.play(anim)

func queue(anim):
	ap.queue(anim)

func clear_queue():
	ap.clear_queue()

func get_input_x():
	return Input.get_axis("ui_left", "ui_right")

func get_jump_input():
	return Input.is_action_just_pressed("ui_accept")

func get_jump_hold():
	return Input.is_action_pressed("ui_accept")
