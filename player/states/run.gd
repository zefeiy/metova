class_name PlayerStateRun extends PlayerState


func init() -> void:
	print("init ->> ", name)
	pass
	
	
func entry() -> void:
	pass
	
func exit()-> void:
	pass
	
func handle_input( _event : InputEvent )-> PlayerState:
	return next_state


func process(delta: float) -> PlayerState:
	return next_state
	
func physics_process(delta: float) -> PlayerState:
	return next_state
