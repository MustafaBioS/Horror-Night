extends Node3D
var entered = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and entered == true:
		get_tree().change_scene_to_file("res://Scenes/house.tscn")
		print("scene changed")

func _on_door_entry_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		entered = true


func _on_door_entry_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		entered = false
