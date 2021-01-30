extends "res://characters/state_machine/state_machine.gd"


func _ready():
	states = {"running": $Running}

	.set_active(true)
	change_state("running")


func change_state(new_state):
	.change_state(new_state)
