@tool
extends Label

## Объект который выводит на экран нужные вам данные с припиской.
class_name PropertyDisplay


##Отображаемая приписка
##[codeblock]
##Строка "FPS", выведет "FPS: {данные}"
##[/codeblock]
@export var title: String = ""


##Если [b]true[/b] округляет полученые значения в ближайшую сторану
##[codeblock]
##значение 2.4, вернёт 2
##значение 2.5, вернёт 3
##значение 2.6, вернёт 3
##[/codeblock]
@export var is_round: bool= false


enum Mode{PROPERTY, CALLBACK}
##От чего ожидать данные, от переменной ([i]PROPERTY[/i]) или функции ([i]CALLBACK[/i])
@export var mode: Mode = Mode.PROPERTY:
	set(value):
		mode = value
		notify_property_list_changed()


enum  NodeType{NODE, TREE, ENGINE, PROJECT_SETTINGS, CUSTOM}
##От какого обьекта нужно взять данные 
@export var object: NodeType = NodeType.NODE:
	set(value):
		object = value
		notify_property_list_changed()


##Путь к узлу. Можно указать только когда "object" выбран как "NODE"
var node_path: NodePath


##Имя синглтона. Можно указать только когда "object" выбран как "CUSTOM"
var singletone_name: StringName = "Engine"


##Название переменной. Можно указать только когда "mode" выбран как "PROPERTY"
var property_name: String = 'name'


##Название функции. Можно указать только когда "mode" выбран как "CALLBACK"
var callback_name: String = ''


##Аргументы функции. Можно указать только когда "mode" выбран как "CALLBACK"
var callback_arguments = Array()


func _ready() -> void:
	set("theme_override_constants/outline_size", 4)
	set("theme_override_colors/font_outline_color", Color.BLACK)


func _process(_delta: float) -> void:
	if Engine.is_editor_hint() or not self.visible:
		return
	
	var value 
	match mode:
		Mode.PROPERTY:
			var node = get_used_node()
			value = node.get(property_name)
		
		Mode.CALLBACK:
			var node = get_used_node()
			value = node.callv(callback_name, callback_arguments)
	
	if is_round:
		value = _round(value)
	
	if title == "":
		self.text = "%s" % value
	
	else:
		self.text = "%s: %s" % [title, value]


##Возвращает текущий объект
func get_used_node() -> Object:
	match  object:
		NodeType.NODE:
			return self.get_node(node_path)
		
		NodeType.TREE:
			return get_tree()
	
		NodeType.ENGINE:
			return Engine.get_singleton("Engine")
		
		NodeType.PROJECT_SETTINGS:
			return Engine.get_singleton("ProjectSettings")
		
		NodeType.CUSTOM:
			return Engine.get_singleton(singletone_name)
	
	breakpoint
	return Node.new()


func _round(value):
	match typeof(value):
		TYPE_VECTOR2:
			return Vector2i(value)
	
		TYPE_FLOAT:
			return round(value)


func _get_property_list():
	var properties = []
	
	if object == NodeType.NODE:
		properties.append({
			"name": "node_path",
			"type": TYPE_NODE_PATH,
			"hint": PROPERTY_HINT_NODE_PATH_TO_EDITED_NODE,
		})
	
	elif object == NodeType.CUSTOM:
		properties.append({
			"name": "singletone_name",
			"type": TYPE_STRING_NAME,
			"hint": PROPERTY_HINT_PLACEHOLDER_TEXT,
			"hint_string": "Engine",
		})
	
	match mode:
		Mode.PROPERTY:
			properties.append({
				"name": "property_name",
				"type": TYPE_STRING,
			})
		
		Mode.CALLBACK:
			properties.append({
				"name": "callback_name",
				"type": TYPE_STRING,
			})
			properties.append({
				"name": "callback_arguments",
				"type": TYPE_ARRAY,
				"hint": PROPERTY_HINT_ARRAY_TYPE,
			})

	return properties
