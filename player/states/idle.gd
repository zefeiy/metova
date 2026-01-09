class_name PlayerStateIdle extends PlayerState

func init() -> void:
	print("init ->> ", name)
	pass
	
	
func entry() -> void:
	player.animation_player.play("idle")
	pass
	
func exit()-> void:
	pass
	
func handle_input( _event : InputEvent )-> PlayerState:
	if _event.is_action_pressed("up"):
		return jump
	
	return next_state


func process(delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	elif player.direction.y > 0.5:
		return crouch
	
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	player.velocity.x = 0
	
	if player.is_on_floor() == false:
		return fall
	
	return next_state
