extends CanvasLayer
@onready var pause = $"."
@onready var hud = $"../HUD"
@onready var options = $"../Options"
@onready var btns = $ButtonCon
@onready var title = $Title
@onready var anim = $"../Fade/AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options.visible = false
	btns.visible = true
	title.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if State.options == true:
		if Input.is_action_just_pressed("back"):
			State.options = false
			options.visible = false
			btns.visible = true
			title.visible = true
	
	
func _on_resume_pressed() -> void:
	pause.visible = false
	State.paused = false
	hud.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _on_options_pressed() -> void:
	State.options = true
	options.visible = true
	btns.visible = false
	title.visible = false


func _on_menu_pressed() -> void:
	anim.play("FadeOut")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	State.options = false
	options.visible = false
	btns.visible = true
	title.visible = true
