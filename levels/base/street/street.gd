extends StaticBody2D

export var max_powerup = 3

var powerup = preload("res://levels/base/elements/powerup.tscn")

var rng = RandomNumberGenerator.new()


func _ready():
	$NextZone.connect("body_entered", get_node("/root/BaseLevel"), "_on_next_zone_entered", [self])

	var spawn_extends = $Spawns.get_child(0).shape.extents

	for _i in range(max_powerup):
		rng.randomize()
		var powerup_position = Vector2()
		powerup_position.x = rng.randi_range(-spawn_extends.x + 10, spawn_extends.x - 20)
		powerup_position.y = rng.randi_range(-spawn_extends.y + 10, spawn_extends.y - 20)

		var new_powerup = powerup.instance()
		new_powerup.position = powerup_position
		$Spawns.call_deferred("add_child", new_powerup)


func _on_InScreen_screen_exited():
	queue_free()
