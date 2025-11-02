extends Area3D
@onready var anim1 = $"../Falling Tree/AnimationPlayer"
@onready var anim2 = $"../Falling Tree 2/AnimationPlayer"
@onready var camera = $"../../../Player/Camera3D"
@onready var temp = $"../../../TempCollision"
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://ckd6gefq02cv6")

func action() -> void:
	if State.sec_dial_done == false:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

func _on_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		if State.first_scene_done == false:
			State.in_scene = true
			
			anim1.play("fall")
			anim2.play("fall2")
			
			await get_tree().create_timer(2.0).timeout
			action()
			State.first_scene_done = true
			State.in_scene = false
			State.objective = "Go to the house"
			
			temp.queue_free()
