extends Node3D

var turned_on = false

func _process(_delta: float) -> void:
	if not turned_on:
		$Label3D.visible = (position-Globals.player_position).length() < 3
		if $Label3D.visible and Input.is_action_just_pressed("start_computer"):
			start()
			
func start():
	turned_on = true
	
