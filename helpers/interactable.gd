extends Area2D

@export var Dialog_Balloon: PackedScene = load("res://ui/dialogue_balloon/balloon.tscn")
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func interact() -> void:
	assert(dialogue_resource != null, "\"dialogue_resource\" property needs to point to a DialogueResource.")
	var balloon: Node = Dialog_Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
