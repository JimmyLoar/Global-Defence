extends Node2D

@export var level_data: Resource
var cell_size = Vector2i.ONE * ProjectSettings.get_setting("game_settings/global/defence/cell_size")
var world_size = ProjectSettings.get_setting("game_settings/global/defence/world_size")
var world_offset = ProjectSettings.get_setting("game_settings/global/defence/world_offset")


func _draw() -> void:
	if get_tree().debug_collisions_hint:
		draw_grid()


func draw_grid():
	for x in world_size.x + 1:
			pass
	
	for y in world_size.y + 1:
		pass
