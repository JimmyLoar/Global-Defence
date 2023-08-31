class_name StructureDisplay
extends Node2D

@export var structure: GridStructure

var cell_draw_bordel = Vector2.ONE * ProjectSettings.get_setting("game_settings/global/debug/cell_border")
var rotate_side = 0:
	set(value):
		rotate_side = value
		queue_redraw()


func _draw():
	_draw_subcells()
	draw_circle(Vector2.ZERO, 4, Color.RED)
	_draw_outline()


func _draw_subcells() -> void:
	var center = structure.get_center(rotate_side)
	for pos in structure.get_rotated_structure(rotate_side):
		var cell_pos = pos - center
		var rect_size = structure.cell_size - cell_draw_bordel * 2
		var rect_position = cell_pos * structure.cell_size - (structure.cell_offset - cell_draw_bordel)
		draw_rect(Rect2(rect_position, rect_size), Color.WHITE * structure.cell_modulate)


func _draw_outline():
	var center := structure.get_center(rotate_side)
	var points = structure.get_outline(rotate_side)
	var offset = structure.get_center(rotate_side) * structure.cell_size * -1 
	for ind in points.size() - 1:
		draw_line(points[ind] + offset, points[ind + 1] + offset, Color.BLUE, 4)
