extends Camera3D

var RAY_LENGTH = 10

var HOLD_LENGTH = 2

var grabbedObject : RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		raycast()

func raycast() -> void:
	var space_state = get_world_3d().direct_space_state
	
	var collision_mask : int = 0xFFF
	
	var query = PhysicsRayQueryParameters3D.create(global_position, global_position - global_basis.z*RAY_LENGTH, collision_mask, [self.get_parent_node_3d()])
	var result = space_state.intersect_ray(query)
	
	var object = result.get('collider')
	
	if (object and object.is_in_group("Pickable")):
		print("yesss")
		grabbedObject = object
	else:
		print("noe")

func _physics_process(delta: float) -> void:
	
	if not grabbedObject: return
	
	var hold_pos = global_position - global_basis.z*HOLD_LENGTH
	var diff = hold_pos - grabbedObject.position
	print(diff)
	
	grabbedObject.move_and_collide(diff)
	
	grabbedObject.linear_velocity = Vector3(diff*10)
	
	
