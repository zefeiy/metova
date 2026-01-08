class_name Player extends CharacterBody2D


#region /// export Variables
@export var move_speed : float = 150
#endregion

#region /// State Machine Variables
var states : Array[PlayerState]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState :
	get : return states[1]
#endregion

#region /// standard Variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_mulitplier : float = 1.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shapestatnd: CollisionShape2D = $CollisionShapestatnd
@onready var collision_shapecrouch: CollisionShape2D = $CollisionShapecrouch
@onready var one_way_platform_ray_cast: RayCast2D = $OneWayPlatformRayCast

#endregion


func _ready() -> void:
	# initil
	initialize_states()
	pass

func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handle_input(event))
	pass

func _process(delta: float) -> void:
	update_direction()
	change_state( current_state.process( delta ))
	pass	
	

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta * gravity_mulitplier
	move_and_slide()
	change_state( current_state.physics_process( delta ))
	pass
	
	
func initialize_states() -> void:
	states = []
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c ) 
			c.player = self
	print(states)
	
	if states.size() == 0:
		return
	
	#initialize all state
	for state in states:
		state.init()
		
	# set our first state
	change_state(current_state)
	$Label.text = current_state.name
	pass
	
	
func change_state( new_state : PlayerState ) -> void:
	if(new_state == null || new_state == current_state):
		return
		
	if current_state:
		current_state.exit()
	states.push_front(new_state)
	states.resize(3)
	current_state.entry()
	$Label.text = current_state.name
	pass

func update_direction() -> void:
	var pre_direction : Vector2 = direction
	direction = Input.get_vector("left", "right", "up", "down")
	pass
