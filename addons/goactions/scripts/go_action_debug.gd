@tool
@icon("res://addons/goactions/icons/go_action_debug.svg")
class_name GoActionDebug extends GoAction
## Debug node used in combination with [GoActionSequence]
## and [GoActionParallelSequence] nodes.
##
## Triggering this node will push a warning with the current
## timestamp along with the [member message] specified.

## Debug message will only print if enabled.
@export var enabled:bool = true

## String to print along with the timestamp upon trigger. 
@export var message:String

func _trigger()->void:
	if OS.is_debug_build() and enabled:
		var full_string:String = Time.get_time_string_from_system()
		full_string += " <%s>" % message
		push_warning(full_string)
