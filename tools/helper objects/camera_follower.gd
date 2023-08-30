extends Camera2D
class_name Camera2DFollower

var followe_node: Node2D:
	set(value):
		followe_node = value


func _ready() -> void:
	self.make_current() 


func _process(delta: float) -> void:
	if not followe_node:
		return
	
	self.global_position = self.followe_node.global_position

