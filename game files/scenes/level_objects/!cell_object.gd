class_name CellObject
extends Node2D

@export var structure: GridStructure


func _process(_delta: float) -> void:
	self.position = get_global_mouse_position()
