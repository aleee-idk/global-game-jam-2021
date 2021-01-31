extends "res://characters/state_machine/state.gd"


func enter():
	owner.adjust_rotation(1)


func handle_input(event):
	pass


func update(delta):
	owner.move()
	# if owner.rotation_degrees > abs(85) or owner.rotation_degrees < abs(95):
	# 	emit_signal("finished", "running")
