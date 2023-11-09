extends Node
class_name Main

static var save_file_path = "user://save/"
static var save_file_name = "save.tres"

# Called when the node enters the scene tree for the first time.
func _ready():
	verify_save_directory(save_file_path)

func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)

static func load_game():
	Globals.playerVariables = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	
static func save_game():
		ResourceSaver.save(Globals.playerVariables, save_file_path + save_file_name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
