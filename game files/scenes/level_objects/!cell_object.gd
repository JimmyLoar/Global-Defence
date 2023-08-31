class_name CellObject
extends Node2D

@export var structure: GridStructure
@onready var collision_shape_2d: CollisionPolygon2D = $CollisionShape2D


func _process(_delta: float) -> void:
	self.position = get_global_mouse_position()
