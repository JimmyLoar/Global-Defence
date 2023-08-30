@tool
class_name GameResource
extends Resource

@export_placeholder("Empty Game Resorce") var game_name: String = ""
@export var project_name: StringName = "resource"

@export_multiline var discription := "" 
@export var texture: Texture = preload("res://icon.svg")
@export var modulate := Color.WHITE

@export_enum("Number", "Texture") var display_mode := 0
@export_range(0, pow(2, 31) - 1, 1, "hide_slider") var maximum: int = int(pow(2, 32))




func get_translate_name():
	return TranslationServer.translate(game_name)


func get_transate_discription():
	return TranslationServer.translate(discription)




func _get_property_list():
	var properties := []
	return properties


func _property_can_revert(property):
	match property:
		"": return true


func _property_get_revert(property):
	match property:
		"": return null
