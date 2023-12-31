extends Area2D

@export var Dialog_Balloon: PackedScene = load("res://ui/dialogue_balloon/balloon.tscn")
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _on_body_entered(body):
	if body is Player and not Globals.playerVariables.met_ai:
		assert(dialogue_resource != null, "\"dialogue_resource\" property needs to point to a DialogueResource.")
		#TODO: Better way to communicate with the player?
		var player = get_node("/root/GameManager/World/Player")
		player.input_direction = Vector2.ZERO
		var balloon: Node = Dialog_Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)
