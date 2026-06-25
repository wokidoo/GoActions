@tool
@icon("res://addons/goactions/icons/go_action_delay.svg")
class_name GoActionDelay extends GoAction
## Starts a timer upon calling [member trigger].
##
## Used in combination with [GoActionSequence] or
## [GoActionParallelSequence] nodes to alter the timing between
## [GoAction] triggers.

## Duration of delay in seconds.
@export var duration:float = 1.0:
	set(val):
		duration = maxf(0.0,val)

func _trigger()->void:
	var timer := get_tree().create_timer(duration)
	await timer.timeout
