extends CharacterBody3D

@onready var spring_arm: Node3D = get_node("SpringArm3D")
@onready var cam: Node3D = spring_arm.get_node("Camera")

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 3.0
const MOUSE_SENS: float = 0.25
var grav = ProjectSettings.get_setting("physics/3d/default_gravity")

#var grav = 9.8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= grav*delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if dir:
		velocity.x = dir.x*SPEED
		velocity.z = dir.z*SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
		velocity.z = move_toward(velocity.z,0,SPEED)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:		
		rotate_y(deg_to_rad(-event.relative.x*MOUSE_SENS))
		spring_arm.rotate_x(deg_to_rad(-event.relative.y*MOUSE_SENS))
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, -89, 89)
