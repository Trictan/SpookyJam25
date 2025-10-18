extends Node3D

var turned_on = false
var turning_on = false

@export_multiline var idle_text: String
@export_multiline var new_task_text: String
@export_multiline var completed_confirm_text: String

enum States {
	idle,
	new_task,
	completed_confirm
}
var state: States = States.idle

func _process(_delta: float) -> void:
	if not turned_on:
		if not turning_on:
			$Label3D.visible = (position-Globals.player_position).length() < 3
		if $Label3D.visible and Input.is_action_just_pressed("start_computer"):
			$Label3D.visible = false
			turning_on = true
			start()
		return
	
	match state:
		States.idle:
			$SubViewport/computer_text.text = idle_text
		States.new_task:
			$SubViewport/computer_text.text = new_task_text
		States.completed_confirm:
			$SubViewport/computer_text.text = completed_confirm_text
			
func start():
	set_text_anim("starting")
	await get_tree().create_timer(1).timeout
	for i in range(5):
		$SubViewport/computer_text.text += "."
		await get_tree().create_timer(0.5).timeout
	turned_on = true
	#var on_button: Node3D = $terminal_with_mats.get_node("Cube_118")

func set_text_anim(text: String):
	$SubViewport/computer_text.text = ""
	for i in text:
		await get_tree().create_timer(0.05).timeout
		$SubViewport/computer_text.text += i
