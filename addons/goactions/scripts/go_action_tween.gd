@tool
@icon("res://addons/goactions/icons/go_action_tween.svg")
class_name GoActionTween extends GoAction
## Tweens the property of the [member target_node] when
## [code]trigger()[/code] is called.
##
## If [code]trigger()[/code] is called before the tween operation
## is finished, target's properties initial value is restored before
## starting a new tween operation.

## Target node whose property will be tweened. 
@export var target_node:Node:
	set(val):
		if _tween and _tween.is_valid():
			return
		target_node = val
## Path to the property to tween. 
@export var property_path:String:
	set(val):
		if _tween and _tween.is_valid():
			return
		property_path = val
## Final value desired for the tween operation.
@export var final_value:Variant:
	set(val):
		if _tween and _tween.is_valid():
			return
		final_value = val
## Duration of the tween operation in seconds.
@export var duration:float = 1.0:
	set(val):
		if _tween and _tween.is_valid():
			return
		duration = val
## [enum Tween.TransType] for the tween operation. 
@export var trans:Tween.TransitionType:
	set(val):
		if _tween and _tween.is_valid():
			return
		trans = val
## [enum Tween.EaseType] for the tween operation. 
@export var ease:Tween.EaseType:
	set(val):
		if _tween and _tween.is_valid():
			return
		ease = val
## If true, the initial value of the target property
## will be restored after the tween operation ends.
@export var restore_initial_value:bool = true:
	set(val):
		if _tween and _tween.is_valid():
			return
		restore_initial_value = val

var _tween:Tween
var _initial_value:Variant

func _trigger()->void:
	if _tween and _tween.is_valid():
		_tween.kill()
		target_node.set(property_path,_initial_value)
	_initial_value = target_node.get(property_path)
	_tween = get_tree().create_tween()
	_tween.bind_node(target_node)
	_tween.tween_property(target_node,
		property_path,
		final_value,
		duration
	).set_trans(trans).set_ease(ease)
	while _tween.is_valid():
		await get_tree().physics_frame
	if restore_initial_value:
		target_node.set(property_path,_initial_value)
