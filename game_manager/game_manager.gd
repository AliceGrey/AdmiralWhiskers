extends Node
class_name GameManager

static var save_file_path = "user://save/"
static var save_file_name = "save.tres"

@export var PlayerScene: PackedScene
@export var NPC_Scene: PackedScene
@export var WorldScene: PackedScene

@export var ui: UI

@onready var camera: Camera = $Camera2D

signal toggle_game_paused()
signal save_game_signal()

var player: Player
var npc: NPC
var world: World

# Called when the node enters the scene tree for the first time.
func _ready():
	_verify_save_directory(save_file_path)
	connect("save_game_signal",save_game)

func _input(event : InputEvent):
	if event.is_action_pressed("ui_focus_next"):
		camera.change_target(npc)
	if event.is_action_pressed("ui_focus_prev"):
		camera.change_target(player)

func new_game():
	#Init World
	world = WorldScene.instantiate()
	add_child(world)
	move_child(world, 0)
	
	#Init Player
	player = PlayerScene.instantiate()
	world.add_child(player)
	player.position = Vector2(0,0)
	
	npc = NPC_Scene.instantiate()
	world.add_child(npc)
	npc.position = Vector2(-916,150)
	
	#Init Camera
	camera.change_target(player)
	await get_tree().create_timer(2).timeout
	get_tree().paused = false

func load_game():
	Globals.playerVariables = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	world = WorldScene.instantiate()
	add_child(world)
	move_child(world, 0)
	
	player = PlayerScene.instantiate()
	world.add_child(player)
	player.position = Globals.playerVariables.global_position
	
	get_tree().paused = false

func start_game():
	#TODO: Add common code between load_game and new_game here
	pass

func _verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)

func save_game():
	Globals.playerVariables.global_position = player.position
	ResourceSaver.save(Globals.playerVariables, save_file_path + save_file_name)

#SIGNALS#
func _on_ui_new_game():
	new_game()

func _on_ui_save_game():
	save_game()

func _on_ui_load_game():
	load_game()

func _on_ui_quit_to_menu():
	if world:
		world.queue_free()
		world = null
		player = null

func _on_ui_pause_menu_closed():
	get_tree().paused = false

func _on_ui_pause_menu_opened():
	get_tree().paused = true
