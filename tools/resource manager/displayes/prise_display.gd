@tool
class_name PriseDisplay
extends ResourceDisplay

@export var prise: int = 0:
	set(value):
		prise = int(value)
		if self.get_parent(): 
			update_value_text(prise)


func _ready() -> void:
	update_data()


func update_value() -> void:
	update_value_text(prise)
