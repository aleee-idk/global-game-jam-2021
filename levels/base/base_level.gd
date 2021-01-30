extends Node2D

var street_x = 2560
var street_y = 1440

var street = preload("res://levels/base/street/street.tscn")


func _on_next_zone_entered(body, prev_zone):
	if body.is_in_group("player"):
		var new_street = street.instance()
		new_street.position.y = prev_zone.position.y - street_y
		$Map.call_deferred("add_child", new_street)
