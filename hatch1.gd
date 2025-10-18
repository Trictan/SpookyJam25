extends CSGBox3D

var tween = create_tween()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Define the target position and duration
	var target_position = Vector3(0, 2.528, 3.808)
	var duration = 2.0

	# Tween the position property over 2 seconds
	tween.tween_property(self, "position", target_position, duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
