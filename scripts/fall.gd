extends State

func enter():
	obj.play("fall")

func physics_update(delta):
	obj.update_velocity(delta)
	obj.move_and_slide()
	if obj.is_on_floor():
		if not obj.jump_buffer_timer.is_stopped():
			change_state("jump")
		else:
			change_state("run" if obj.get_input_x() != 0 else "idle")
