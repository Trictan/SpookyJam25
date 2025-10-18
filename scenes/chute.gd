extends Node3D

@onready var hatch = get_node("Hatch")

var open_rot = Vector3(deg_to_rad(120), 0, 0)
var closed_rot = Vector3(0, 0, 0)
var duration = 0.5

var min_radius = 5

var opening = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var shouldOpen = ((Globals.player_position - self.position)*Vector3(1,0,1)).length() < min_radius
	#print("a")
	if shouldOpen and (not opening):
		print("b")
		var tween = create_tween()
		tween.tween_property(hatch, "rotation", open_rot, duration)
		opening = true
	if (not shouldOpen) and opening:
		print("c")
		var tween = create_tween()
		tween.tween_property(hatch, "rotation", closed_rot, duration)
		opening = false 
