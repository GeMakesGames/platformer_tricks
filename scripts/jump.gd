extends State

func enter():
	obj.play("jump")
	obj.velocity.y = Player.JUMP_SPEED

func physics_update(delta):
	obj.update_velocity(delta)
	obj.move_and_slide()
	if obj.velocity.y >= 0:
		change_state("fall")
	
