extends Control
class_name PauseMenu

signal quit_to_menu()
signal return_to_game()
signal save_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _on_resume_button_pressed():
	return_to_game.emit()

func _on_load_button_pressed():
	#TODO: Add load save menu
	pass # Replace with function body.

func _on_save_button_pressed():
	#TODO: Provide player feedback that game was saved sucessfully
	save_game.emit()
	return_to_game.emit()

func _on_menu_button_pressed():
	#TODO: Add "are you sure you want to quit" popup
	quit_to_menu.emit()

func _on_exit_button_pressed():
	#TODO: Add "are you sure you want to quit" popup
	get_tree().quit()
