extends Camera3D

var RAY_LENGTH = 10

var HOLD_LENGTH = 2
var ROTATE_SENS = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			raycast()
		if event.is_released():
			Globals.grabbedObject = null
	
	if Globals.grabbedObject and Globals.player_is_rotating_object and event is InputEventMouseMotion:
		var dx = -event.relative.x*ROTATE_SENS
		var dy = -event.relative.y*ROTATE_SENS
		
		print(dx)
		
		Globals.grabbedObject.angular_velocity = Vector3(dy, -dx, 0)
		
		#grabbedObject.rotate_object_local(Vector3(1,0,0), dx)
		#grabbedObject.rotate_object_local(Vector3(0,1,0), dy)


func raycast() -> void:
	var space_state = get_world_3d().direct_space_state
	
	var collision_mask : int = 0xFFF
	
	var query = PhysicsRayQueryParameters3D.create(global_position, global_position - global_basis.z*RAY_LENGTH, collision_mask, [self.get_parent_node_3d()])
	var result = space_state.intersect_ray(query)
	
	var object = result.get('collider')
	
	if (object and object.is_in_group("Pickable")):
		print("yesss")
		Globals.grabbedObject = object
	else:
		print("noe")

func _physics_process(delta: float) -> void:
	
	if not Globals.grabbedObject: return
	
	var hold_pos = global_position - global_basis.z*HOLD_LENGTH
	var diff = hold_pos - Globals.grabbedObject.position
	
	Globals.grabbedObject.move_and_collide(diff)
	
	Globals.grabbedObject.linear_velocity = Vector3(diff*10)
	
