class_name PlayerStateCrouch extends PlayerState

@export var Deceleration_Rat : float = 10.0

func init() -> void:
	print("init ->> ", name)
	pass
	
	
func entry() -> void:
	player.collision_shapestatnd.disabled = true
	player.collision_shapecrouch.disabled = false
	player.sprite_2d.scale.y = 0.625
	player.sprite_2d.position.y = -15.0
	pass
	
func exit()-> void:
	player.collision_shapestatnd.disabled = false
	player.collision_shapecrouch.disabled = true
	player.sprite_2d.scale.y = 1.0
	player.sprite_2d.position.y = -24.0
	pass
	
func handle_input( _event : InputEvent )-> PlayerState:
	if _event.is_action_pressed("up"):
		if player.one_way_platform_ray_cast.is_colliding() == true:
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
