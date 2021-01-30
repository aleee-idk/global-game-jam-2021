extends Node2D

var street = preload("res://levels/base/street.tscn")


func _on_next_zone_entered(body):
    if body.is_in_group("player"):
        print("enter")
		# var new_street = street.instance()
		# new_street.position.y = position.y
		# $Map.add_child(new_street)
