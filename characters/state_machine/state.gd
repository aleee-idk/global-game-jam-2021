extends Node

signal finished(nextState)

onready var animPlayer: AnimationPlayer

func enter():
	emit_signal("finished")

func update(delta):
	return delta

func handle_input(event):
	return event
