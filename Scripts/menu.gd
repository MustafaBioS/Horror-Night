extends Control
@onready var options = $Options
@onready var btns = $ButtonCon
@onready var title = $Title
@onready var anim = $Fade/AnimationPlayer


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	options.visible = false
	btns.visible = true
	title.visible = true
	State.in_dial = false
	State.first_dial_done = false
	State.in_scene = false
	State.first_scene_done = false
	State.objective = "Go to the garden"
	State.sec_dial_done = false
	State.paused = false
	State.options = false
	State.died = false
	anim.play("FadeIn")
	await anim.animation_finished
	
func _process(delta: float) -> void:
	if State.options == true:
		if Input.is_action_just_pressed("back"):
			State.options = false
			options.visible = false
			btns.visible = true
			title.visible = true

func _on_play_pressed() -> void:
	anim.play("FadeOut")
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_options_pressed() -> void:
	State.options = true
	options.visible = true
	btns.visible = false
	title.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	State.options = false
	options.visible = false
	btns.visible = true
	title.visible = true
