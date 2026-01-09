class_name PlayerStateJump extends PlayerState

@export var jump_velocity : float = 450.0

func init() -> void:
	print("init ->> ", name)
	pass
	
	
func entry() -> void:
	player.velocity.y = -jump_velocity
	player.animation_player.play("jump")
	player.animation_player.pause()
	pass
	
func exit()-> void:
	pass
	
func handle_input( _event : InputEvent )-> PlayerState:
	if _event.is_action_released("up"):
		player.velocity.y *= 0.5
		return fall
	return next_state


func process(delta: float) -> PlayerState:
	set_jump_frame()
	
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >=0:
		return fall
		
	player.velocity.x = player.direction.x * player.move_speed
	return next_state


func set_jump_frame() -> void:
	var frame = remap(player.velocity.y, -jump_velocity, 0, 0.0, 0.5)
	player.animation_player.seek(frame, true)
	pass
