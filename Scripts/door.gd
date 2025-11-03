extends Node3D
var entered = false
@onready var anim = $"../../../Fade/AnimationPlayer"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and entered == true:
		anim.play("FadeOut")
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/house.tscn")
		State.objective = "Explore the house"

func _on_door_entry_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		entered = true

func _on_door_entry_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		entered = false
