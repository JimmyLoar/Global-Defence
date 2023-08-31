extends Node2D
var _occupied_cells: Dictionary = {}


func occupy_cells(cells: PackedVector2Array, occuper: CellObject):
	for pos in cells:
		_occupied_cells[pos] = occuper


func unoccupy_cells(cells: PackedVector2Array, occuper: CellObject):
	for pos in cells:
		if _occupied_cells[pos] != occuper:
			print_stack()
			breakpoint
		
		_occupied_cells.erase(pos)


func has_occupied_cell(_pos: Vector2i) -> bool:
	return _occupied_cells.has(_pos)


func get_occuper(pos: Vector2i):
	return _occupied_cells[pos] if has_occupied_cell(pos) else null

