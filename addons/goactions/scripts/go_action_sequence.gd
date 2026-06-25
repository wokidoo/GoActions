@tool
@icon("res://addons/goactions/icons/go_action_sequence.svg")
class_name GoActionSequence extends GoAction
## Triggers a sequence of [GoAction] nodes.
##
## Child [GoAction] nodes will be triggered in order from
## first to last. Sequence will wait for each [GoAction] trigger to
## finish before executing the next one.

## Sequence mode.
enum TriggerMode{
	WAIT, ## Wait for the last sequence to end before starting a new one.
	IGNORE, ## Do nothing if a sequence is already executing.
	INSTANCE ## Trigger a new sequence even if one is already executing.
}

@export var trigger_mode:TriggerMode = TriggerMode.INSTANCE:
	set(val):
		if not _pending:
			trigger_mode = val

var _actions:Array[GoAction] = []
var _pending:bool = false

func _trigger()->void:
	match trigger_mode:
		TriggerMode.WAIT:
			if _pending:
				while _pending:
					await get_tree().process_frame
			_trigger_child_actions()
		TriggerMode.IGNORE:
			if _pending:
				return
			_trigger_child_actions()
		TriggerMode.INSTANCE:
			_trigger_child_actions()

func _trigger_child_actions():
	_pending = true
	for action in _actions:
		await action.trigger()
	_pending = false

func _cache_child_actions():
	_actions.clear()
	for action in get_children():
		if action is GoAction:
			_actions.append(action)
	update_configuration_warnings()

func _enter_tree() -> void:
	_cache_child_actions()

func _notification(what: int) -> void:
	if what == NOTIFICATION_CHILD_ORDER_CHANGED:
		_cache_child_actions()

func _get_configuration_warnings() -> PackedStringArray:
	for child in get_children():
		if not child is GoAction:
			return ["All child nodes should be of type GoAction"]
	return []
