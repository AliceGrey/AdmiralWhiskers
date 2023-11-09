extends CanvasLayer
class_name UI

signal new_game()
signal load_game()
signal save_game()

signal pause_menu_opened()
signal pause_menu_closed()
signal quit_to_menu()

@onready var main_menu = %MainMenu
@onready var pause_menu = %PauseMenu
@onready var animation_player = %AnimationPlayer
@onready var transition = %Transition

func _input(event : InputEvent):
	if !main_menu.visible and event.is_action_pressed("ui_cancel"):
		pause_menu.visible = !pause_menu.visible
		if pause_menu.visible:
			pause_menu_opened.emit()

func _on_main_menu_new_game() -> void:
	new_game.emit()
	transition.show()
	animation_player.play("screen_transition")
	await animation_player.animation_finished
	transition.hide()

func _on_main_menu_load_game():
	load_game.emit()
	transition.show()
	animation_player.play("screen_transition")
	await animation_player.animation_finished
	transition.hide()

func _on_pause_menu_save_game() -> void:
	save_game.emit()
	pause_menu.hide()

func _on_pause_menu_quit_to_menu():
	if animation_player.is_playing():
		await animation_player.animation_finished
	pause_menu.hide()
	transition.show()
	animation_player.play_backwards("screen_transition")
	await animation_player.animation_finished
	transition.hide()
	quit_to_menu.emit()
	main_menu.show()

func _on_pause_menu_return_to_game():
	if animation_player.is_playing():
		await animation_player.animation_finished
	pause_menu.hide()
	pause_menu_closed.emit()
