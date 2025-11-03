extends CharacterBody3D

@onready var camera = $Camera3D
@onready var pause = $"../Pause"
@onready var hud = $"../HUD"
@onready var anim = $"../Fade/AnimationPlayer"
@onready var died = $"../Died"

const SPEED = 15.0
const JUMP_VELOCITY = 6.0
var sensitivity = 0.003

func player():
	pass

func _ready() -> void:
	State.paused = false
	pause.visible = false
	hud.visible = true
	died.visible = false
	anim.play("FadeIn")
	await anim.animation_finished
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and State.in_dial == false and State.in_scene == false and State.options == false:
		if State.paused == false:
			pause.visible = true
			State.paused = true
			hud.visible = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			sensitivity = 0
			
		elif State.paused == true:
			pause.visible = false
			State.paused = false
			hud.visible = true
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			sensitivity = 0.003

	if State.paused == false and State.options == false:
		sensitivity = 0.003
	
	elif State.paused == true and State.options == false:
		sensitivity = 0
	
	if State.died == true:
		died.visible = true
		await get_tree().create_timer(1.5).timeout
		anim.play("FadeOut")
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	elif State.died == false:
		died.visible = false
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and State.paused == false:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and State.in_dial == false and State.in_scene == false and State.paused == false and State.options == false:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and State.in_dial == false and State.in_scene == false and State.paused == false and State.options == false:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if State.in_dial == false and State.in_scene == false and State.paused == false and State.options == false:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if State.in_dial == false and State.in_scene == false and State.paused == false and State.options == false:
		move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(70))
