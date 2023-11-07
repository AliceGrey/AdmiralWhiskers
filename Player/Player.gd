extends CharacterBody2D
class_name Player

@export var Dialog_Balloon: PackedScene = load("res://UI/Dialogue/dialog_balloon/balloon.tscn")
@export var title: String = "start"
@export var dialogue_resource: DialogueResource

enum States { MOVE }

@export var speed := 100.0
@export var acceleration := 1000.0
@export var decceleration := 1000.0
@export var aim_deadzone := 0.2

var direction := Vector2.DOWN
var input_direction := Vector2.ZERO

@onready var skin: PlayerSkin = $PlayerSkin


func _ready() -> void:
	skin.play_animation("Idle")
	

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and not Globals.playerVariables.met_ai:
		assert(dialogue_resource != null, "\"dialogue_resource\" property needs to point to a DialogueResource.")
		
		input_direction = Vector2.ZERO
		
		var balloon: Node = Dialog_Balloon.instantiate()
		add_child(balloon)
		balloon.start(dialogue_resource, title)
		return
	input_direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).limit_length(1.0)


func _physics_process(delta: float) -> void:
	if input_direction.is_zero_approx():
		velocity = velocity.move_toward(Vector2.ZERO, decceleration * delta)
		skin.play_animation("Idle")
		skin.set_blend_position(direction)
	else:
		velocity += input_direction * acceleration * delta
		velocity = velocity.limit_length(speed * input_direction.length())
		if input_direction.length() > aim_deadzone:
			direction = input_direction.normalized()
		skin.play_animation("Move")
		skin.set_blend_position(input_direction, input_direction.length())
	
	move_and_slide()
