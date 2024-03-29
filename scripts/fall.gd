extends State

@onready var coyote_timer = $CoyoteTimer

func enter():
	obj.play("fall")
	if fsm.previous_state != "jump":
		coyote_timer.start()

func physics_update(delta):
	obj.update_velocity(delta)
	obj.move_and_slide()
	if not coyote_timer.is_stopped() and obj.get_jump_input():
		change_state("jump")
	elif obj.is_on_floor():
		if not obj.jump_buffer_timer.is_stopped():
			change_state("jump")
		else:
			change_state("run" if obj.get_input_x() != 0 else "idle")
