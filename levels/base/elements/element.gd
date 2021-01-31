extends Area2D

export var player_speed_variation = 0


func _on_Element_body_entered(body):
	if body.is_in_group("player"):
		body.adjust_speed(player_speed_variation)
		queue_free()
