class_name PlayerStateCrouch extends PlayerState

@export var Deceleration_Rat : float = 10.0

func init() -> void:
	print("init ->> ", name)
	pass
	
	
func entry() -> void:
	player.collision_shapestatnd.disabled = true
	player.collision_shapecrouch.disabled = false
	player.animation_player.play("crouch")
	pass
	
func exit()-> void:
	player.collision_shapestatnd.disabled = false
	player.collision_shapecrouch.disabled = true
	pass
	
func handle_input( _event : InputEvent )-> PlayerState:
	if _event.is_action_pressed("up"):
		player.one_way_platform_rectangle_ray_cast.force_shapecast_update()
		if player.one_way_platform_rectangle_ray_cast.is_colliding() == true:
			player.position.y += 4
			return fall
		
		return jump
	
	return next_state


func process(delta: float) -> PlayerState:
	#if player.direction.x == 0:
		#return idle
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * delta * Deceleration_Rat
	if player.direction.y <= 0.5:
		return idle
	
	return next_state
