extends Camera2D
class_name Camera

enum MODES { TARGET, TARGET_MOUSE_BLENDED }

@export var target: Node = null
@export var mode: MODES = MODES.TARGET
@export var MAX_DISTANCE : float = 50
@export var SMOOTH_SPEED : float = 5

var target_position := Vector2.INF
var fallback_target: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	fallback_target = target
	pass # Replace with function body.

func _process(delta):
	match(mode):
		MODES.TARGET:
			if target:
				target_position = target.position
		MODES.TARGET_MOUSE_BLENDED:
			var mouse_pos := get_local_mouse_position()
			target_position = (target.position + mouse_pos)
	if target_position != Vector2.INF:
		position = lerp(position, target_position, SMOOTH_SPEED * delta)

func change_target(new_target: Node) -> void:
	if new_target:
		if target and target.tree_exiting.is_connected(_clear_target):
			target.tree_exiting.disconnect(_clear_target)
	target = new_target
	new_target.tree_exiting.connect(_clear_target)

func _clear_target() -> void:
	target = fallback_target
