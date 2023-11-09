extends CanvasLayer
class_name UI

signal new_game()
signal load_game()
signal save_game()
signal toggle_game_paused()

@onready var main_menu = %MainMenu

func _on_main_menu_new_game() -> void:
	new_game.emit()

func _on_pause_menu_save_game() -> void:
	save_game.emit()

func _on_pause_menu_toggle_game_paused():
	toggle_game_paused.emit()

func _on_main_menu_load_game():
	load_game.emit()
