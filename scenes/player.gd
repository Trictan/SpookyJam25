extends RigidBody3D


@onready var cam: Node3D = get_node("Camera")

var walk_force: int = 15
var jump_force: int = 3
var walk_slowdown: int = 15
var max_speed: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var got_input = false
	var speed = (linear_velocity*Vector3(1,0,1)).length()
	if speed < max_speed:
		if Input.is_action_pressed("forward"):
			got_input = true
			var forward = -transform.basis.z
			self.apply_central_force(forward*walk_force)
		if Input.is_action_pressed("backward"):
			got_input = true
			var backward = transform.basis.z
			self.apply_central_force(backward*walk_force)
		if Input.is_action_pressed("left"):
			got_input = true
			var forward = -transform.basis.x
			self.apply_central_force(forward*walk_force)
		if Input.is_action_pressed("right"):
			got_input = true
			var forward = transform.basis.x
			self.apply_central_force(forward*walk_force)
	if Input.is_action_just_pressed("jump"):
		self.apply_central_impulse(Vector3(0,1,0)*jump_force)
	if not got_input:
		apply_central_force(-linear_velocity*walk_slowdown*Vector3(1,0,1))

	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotate(Vector3(0,1,0), -event.relative.x*0.01)

		cam.rotate(Vector3(1,0,0), -event.relative.y*0.01)
