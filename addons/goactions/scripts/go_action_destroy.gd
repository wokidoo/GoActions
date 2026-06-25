@tool
@icon("res://addons/goactions/icons/go_action_destroy.svg")
class_name GoActionDestroy extends GoAction
## Queues the [member target_node] for destruction when triggered.
##

## Node that will be queued to be destroyed upon trigger.
@export var target_node:Node

func _trigger()->void:
	if not Engine.is_editor_hint():
		target_node.queue_free()
