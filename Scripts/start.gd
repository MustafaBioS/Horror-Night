extends Area3D
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://ckd6gefq02cv6")

func action() -> void:
	if State.first_dial_done == false:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	print(State.first_dial_done)
	print(State.in_dial)
	action()
	print("dialogue started")
	print(State.in_dial)
	print(State.first_dial_done)
