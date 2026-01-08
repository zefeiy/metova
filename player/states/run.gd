class_name PlayerStateRun extends PlayerState


func init() -> void:
	print("init ->> ", name)
	pass
	
	
func entry() -> void:
	pass
	
func exit()-> void:
	pass
	
func handle_input( _event : InputEvent )-> PlayerState:
	if _event.is_action_pressed("up"):
		return jump
	
	return next_state


func process(delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	
	if player.is_on_floor() == false:
		return fall
	
	return next_state
