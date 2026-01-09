class_name PlayerStateFall extends PlayerState

@export var coyote_time : float = 0.4
@export var fall_gravity_mulitplier : float = 1.165
@export var jump_buffer_time = 0.2

var coyote_timer : float = 0
var jump_buffer_timer = 0

func init() -> void:
	print("init ->> ", name)
	pass
	
	
func entry() -> void:
	player.gravity_mulitplier = fall_gravity_mulitplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	player.animation_player.play("jump")
	player.animation_player.pause()	
	pass
	
func exit()-> void:
	player.gravity_mulitplier = 1.0
	pass
	 
func handle_input( _event : InputEvent )-> PlayerState:
	if _event.is_action_pressed("up") and coyote_timer > 0:
		return jump
	elif _event.is_action_pressed("up"):
		jump_buffer_timer = jump_buffer_time
		
	return next_state


func process(delta: float) -> PlayerState:
	coyote_timer-=delta
	jump_buffer_timer-=delta
	set_jump_frame()
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	if player.is_on_floor():
		if jump_buffer_timer > 0 and Input.is_action_pressed("up"):
			return jump
		return idle
		
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
	
	
func set_jump_frame() -> void:
	var frame = remap(player.velocity.y, 0, player.max_fall_velocity, 0.5, 1.0)
	player.animation_player.seek(frame, true)
	pass
