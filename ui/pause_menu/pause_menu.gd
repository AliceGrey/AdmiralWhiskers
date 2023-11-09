extends Control
class_name PauseMenu

signal toggle_game_paused()
signal save_game()
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func on_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()

func _on_resume_button_pressed():
	toggle_game_paused.emit()

func _on_save_button_pressed():
	#TODO: Provide player feedback that game was saved sucessfully
	save_game.emit()
	toggle_game_paused.emit()

func _on_exit_button_pressed():
	#TODO: Add "are you sure you want to quit" popup
	get_tree().quit()
