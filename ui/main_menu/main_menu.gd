extends Control

signal new_game()
signal load_game()

func _on_new_game_button_pressed():
	new_game.emit()
	hide()

func _on_load_button_pressed():
	#TODO: Add save game selector
	load_game.emit()
	hide()

func _on_settings_button_pressed():
	#TODO: Settings menu
	pass # Replace with function body.

func _on_exit_button_pressed():
	#TODO: Add "are you sure you want to quit" popup
	get_tree().quit()
