extends Node
class_name GameManager

static var save_file_path = "user://save/"
static var save_file_name = "save.tres"

@export var PlayerScene: PackedScene
@export var WorldScene: PackedScene

@export var ui: UI

signal toggle_game_paused()
signal save_game_signal()

var player: Player
var world: World

# Called when the node enters the scene tree for the first time.
func _ready():
	_verify_save_directory(save_file_path)
	connect("save_game_signal",save_game)

func new_game():
	#Init World
	world = WorldScene.instantiate()
	add_child(world)
	move_child(world, 0)
	
	#Init Player
	player = PlayerScene.instantiate()
	world.add_child(player)
	player.position = Vector2(0,0)
	
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
