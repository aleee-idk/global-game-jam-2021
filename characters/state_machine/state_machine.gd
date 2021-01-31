extends Node

var states: Dictionary = {}
var currentState: Node = null

var _active: bool = false setget set_active


func _ready():
	for child in get_children():
		child.connect("finished", self, "change_state")

	set_active(false)


func _input(event):
	currentState.handle_input(event)


func _physics_process(delta):
	currentState.update(delta)


func change_state(stateName):
	if ! _active:
		return
	currentState = states[stateName]
	currentState.enter()


func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)

	if ! _active:
		currentState = null
