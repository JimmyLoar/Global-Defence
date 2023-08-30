extends Control

@export var start_scene: PackedScene

@onready var title_label = $HBoxContainer/MenuPanel/Margin/VBox/GameTitle
@onready var buttons = $HBoxContainer/MenuPanel/Margin/VBox/Buttons
@onready var scroll_box = $HBoxContainer/Scroll
@onready var screen_container = $HBoxContainer/Scroll/Container/ScreenContainer
@onready var screen_label = $HBoxContainer/Scroll/Container/Label

func _ready(): 
	title_label.text = "%s" % ProjectSettings.get_setting("application/config/name", "NullTitle")
	scroll_box.hide()

func _on_how_to_play_pressed():
	open_screen(0, "How to Play")


func _on_start_pressed():
	get_tree().change_scene_to_packed(start_scene)


func _on_continue_pressed():
	pass # Replace with function body.


func _on_settings_pressed():
	open_screen(1, "Settings")


func _on_about_pressed():
	open_screen(2, "About")


func _on_exit_pressed():
	get_tree().quit()


func open_screen(index: int, sc_name: String = "Screen"):
	scroll_box.show()
	screen_label.text = "  " + sc_name
	screen_container.current_tab = index
