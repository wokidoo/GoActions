@tool
@icon("res://addons/goactions/icons/go_action_destroy.svg")
class_name GoActionDestroy extends GoAction
## Queue's a [member target_node] node to be destroyed upon calling
## [code]trigger()[/code]. 
##

## Node that will be queued to be destroyed upon trigger.
@export var target_node:Node

func _trigger()->void:
	if not Engine.is_editor_hint():
		target_node.queue_free()
