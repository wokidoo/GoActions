@tool
@abstract
@icon("res://addons/goactions/icons/go_action.svg")
class_name GoAction extends Node
## Generic [GoAction] node. Used to trigger behavior in other nodes.
##
## Allows behavior to be triggered in other nodes without
## needing scripting.
## [br][br][color=yellow][b]Note:[/b][/color][br]
## By default, [GoAction] does not do anything. If you would
## like to create your own [GoAction] type, create a new script
## that inherits this class and implement the [code]_trigger()[/code]
## method.
## [br][br][b]Example:[/b]
## [codeblock]
## # Overridable Trigger function
## func _trigger()->void:
## 	# implement behaviour here.
## 	pass
## [/codeblock]

## Trigger the [GoAction] trigger method in the editor.
@export_tool_button("Trigger Action in Editor")
var trigger_tool_button = trigger

## Emitted at the start of the [code]trigger()[/code]
## callback.
signal started()
## Emitted at the end of the [code]trigger()[/code] callback.
signal finished()

## Trigger the [GoAction] behaviour for this node.
## [br][br][color=yellow][b]Warning:[/b][/color][br]
## If you are implementing your own [GoAction] type,
## do not override this method. Instead, override [code]_trigger()[/code].
func trigger()->void:
	started.emit()
	await _trigger()
	finished.emit()

## Overridable Trigger function
func _trigger()->void:
	pass
