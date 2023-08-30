@tool
extends Node

signal value_changed(res_name: StringName, value: int)

const RESOURCES_FOLDER = "res://database/game resources/"

var _resource_data := {}
var _resource_value := Dictionary()




func _init():
	update_resource()


func update_resource() -> void:
	print("ResourceManager | Update START")
	if not DirAccess.dir_exists_absolute(RESOURCES_FOLDER):
		printerr("Not exist '%s' forlder with resource!" % [RESOURCES_FOLDER])
		return
	
	_resource_data.clear()
	var files = DirAccess.get_files_at(RESOURCES_FOLDER)
	print("ResourceManager | Found files %s" % files)
	for filename in files:
		var res: GameResource = load(RESOURCES_FOLDER + filename)
		_resource_data[res.project_name] = res
	
	print("ResourceManager | Loaded resource %s" % _resource_data)
	print("ResourceManager | Update END")
	return 


func get_resource_data(res_name: StringName) -> GameResource:
	if _resource_data.has(res_name): return _resource_data[res_name]
	printerr("ResourceManager | Wrong name '%s'" % res_name)
	print_stack()
	breakpoint
	return null


func get_resources_names_string() -> String:
	var string = ""
	var keys = _resource_data.keys()
	if keys.is_empty():
		printerr("ResourceManager | not resources")
		print_stack()
		return string
	
	string = String(keys[0])
	for index in range(1, keys.size()):
		string += ",%s" % keys[index]
	print("ResourceManager | Get string names '%s'" % string)
	return string


func get_resource_value(res_name: StringName) -> int:
	if _resource_value.has(res_name):
		return _resource_value[res_name]
	return 0


func set_resource_value(res_name: StringName, value = 0) -> void:
	_resource_value[res_name] = int(value)
	emit_signal("value_changed", res_name, value)


func change_resource_value(res_name: StringName, on_value = 0) -> void:
	var value = clampi(get_resource_value(res_name) + on_value, 0, get_resource_data(res_name).maximum)
	set_resource_value(res_name, value)
	emit_signal("value_changed", res_name, value)


func has_resource_value(res_name: StringName, check_value: int = 0, is_decrese := false) -> bool:
	check_value = abs(check_value)
	if get_resource_value(res_name) < check_value:
		return false
	
	if is_decrese:
		change_resource_value(res_name, check_value)
	return true
