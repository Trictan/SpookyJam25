extends CSGBox3D

var open_pos = Vector3(0, 2.528, 3.808)
var closed_pos = Vector3(0, 1.186, 3.808)
var duration = 0.5

var min_radius = 2

var opening = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var shouldOpen = ((Globals.player_position - self.position)*Vector3(1,0,1)).length() < min_radius
	
	if shouldOpen and (not opening):
		var tween = create_tween()
		tween.tween_property(self, "position", open_pos, duration)
		opening = true
	if (not shouldOpen) and opening:
		var tween = create_tween()
		tween.tween_property(self, "position", closed_pos, duration)
		opening = false
	
