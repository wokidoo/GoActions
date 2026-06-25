@tool
@icon("res://addons/goactions/icons/go_action_caller.svg")
class_name GoActionCaller extends GoAction
## Calls a chosen function from the [member target_node] when
## [code]trigger()[/code] is called.
##

## Owner of the method that will be called.
@export var target_node:Node
## Name of the method to call.
@export var method_name:StringName
## List of parameters passed to the method when called.
@export var parameters:Array[Variant] = []

func set_parameters(param:Array[Variant]):
	parameters.assign(param)

func get_parameters()->Array[Variant]:
	return parameters

func _trigger()->void:
	if target_node and target_node.has_method(method_name):
		target_node.callv(method_name,parameters)
