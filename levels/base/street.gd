extends StaticBody2D


func _ready():
	$NextZone.connect("body_entered", get_node("/root/BaseLevel"), "_on_next_zone_entered")
