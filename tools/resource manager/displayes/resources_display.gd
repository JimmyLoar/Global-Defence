@tool
class_name ResourceDisplay
extends PanelContainer

const TEXT_SUFFIX = ["", "K", "M", "B"]

var resource_manager := ResourceManager

var resource_name: StringName:
	set(value):
		resource_name = value
		update_data()

@export var use_modulate := true

@onready var icon: TextureRect = $HBoxContainer/Icon
@onready var value_label: Label = $HBoxContainer/Value


func _ready() -> void:
	update_data()
	resource_manager.value_changed.connect(_on_resource_amount_changed)


func update_data() -> void:
	if not self.get_parent(): return
	var data := resource_manager.get_resource_data(resource_name)
	if data.display_mode != 0:
		push_warning("Not correct mode (%s) this display (%s)" % [data.display_mode, self])
		breakpoint
		return
	
	icon.texture = data.texture
	if not data.texture:
		icon.visible = false
	
	else:
		icon.visible = true
		icon.texture = data.texture
	
	self.tooltip_text = "%s\n%s" % [data.game_name, data.discription]
	value_label.modulate = data.modulate if use_modulate else Color.WHITE
	update_value()


func update_value() -> void:
	var value := resource_manager.get_resource_value(resource_name)
	update_value_text(value)


func update_value_text(value):
	if value > 1000:
		var index = count_value_index(value)
		value_label.text = "%d%s" % [value / pow(1000, index), TEXT_SUFFIX[index]]
	else:
		value_label.text = "%s" % value


func count_value_index(value, index = 0):
	if value > 1000:
		return count_value_index(value / 1000, index + 1)
	return index  


func _on_resource_amount_changed(res_name, _new_value):
	if res_name != resource_name:
		return
	
	update_data()


func _get_property_list():
	var properties := []
	
	properties.append({
		"name": "resource_name",
		"type": TYPE_STRING_NAME,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": resource_manager.get_resources_names_string(),
	})
	return properties
