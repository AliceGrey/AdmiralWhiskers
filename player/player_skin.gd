extends Node2D
class_name PlayerSkin

var current_state := "Idle" : get = get_current_state
var treshhold := 0.01

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]


func get_current_state() -> String:
	return current_state


func set_blend_position(blend_position: Vector2, speed: float = 1.0) -> void:
	if blend_position.length() > treshhold:
		animation_tree.set("parameters/" + current_state + "/blend_position", blend_position)
	
	if current_state == "Move":
		animation_tree.set("parameters/Move/0/TimeScale/scale", speed)
		animation_tree.set("parameters/Move/1/TimeScale/scale", speed)
		animation_tree.set("parameters/Move/2/TimeScale/scale", speed)
		animation_tree.set("parameters/Move/3/TimeScale/scale", speed)


func play_animation(anim_name: String, _from_position: Vector2 = Vector2.ZERO) -> void:
	if anim_name == current_state:
		return

	if not animation_tree.active:
		animation_tree.active = true
	current_state = anim_name
	playback.start(current_state)
