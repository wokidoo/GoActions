@tool
@icon("res://addons/goactions/icons/go_action_parallel_sequence.svg")
class_name GoActionParallelSequence extends GoActionSequence
## Trigger a sequence of [GoAction] nodes in sequence parallel to one another.
##
## Child [GoAction] nodes will be triggered all at once.
## Execution of [code]trigger()[/code] only ends once the last 
## child [GoAction] node finishes executing.

func _trigger()->void:
	match trigger_mode:
		TriggerMode.WAIT:
			if _pending:
				while _pending:
					await get_tree().physics_frame
			await _trigger_child_actions()
		TriggerMode.IGNORE:
			if _pending:
				return
			await _trigger_child_actions()
		TriggerMode.INSTANCE:
			await _trigger_child_actions()

func _trigger_child_actions():
	_pending = true
	var _pending_actions:Array[GoAction] = []
	for action in _actions:
		_add_pending_action(action,_pending_actions)
		action.trigger()
	while not _pending_actions.is_empty():
		await get_tree().physics_frame
	_pending = false

func _add_pending_action(action:GoAction,pending_action_array:Array):
	action.finished.connect(
		_remove_pending_action.bind(action,pending_action_array),
		CONNECT_ONE_SHOT|CONNECT_REFERENCE_COUNTED)
	pending_action_array.append(action)

func _remove_pending_action(action:GoAction,pending_action_array:Array):
	pending_action_array.erase(action)
