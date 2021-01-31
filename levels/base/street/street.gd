extends StaticBody2D

export var max_powerup = 3
export var max_obstacle = 3

var powerup = preload("res://levels/base/elements/powerup.tscn")
var obstacle = preload("res://levels/base/elements/obstacle.tscn")

var rng = RandomNumberGenerator.new()


func _enter_tree():
	if PlayerStats.incorrect_exit:
		$Barricade.position.x = 0
		$Barricade.visible = true
		PlayerStats.incorrect_exit = false

	$NextZone.connect(
		"body_entered", get_node("/root/BaseLevel"), "_on_next_zone_entered", [self, $NextZone]
	)

	var spawn_extends = $Spawns.get_child(0).shape.extents

	for _i in range(rng.randi() % max_powerup + 1):
		rng.randomize()
		var powerup_position = Vector2()
		powerup_position.x = rng.randi_range(-spawn_extends.x + 10, spawn_extends.x - 20)
		powerup_position.y = rng.randi_range(-spawn_extends.y + 10, spawn_extends.y - 20)

		var new_powerup = powerup.instance()
		new_powerup.position = powerup_position
		$Spawns.call_deferred("add_child", new_powerup)

	for _i in range(rng.randi() % max_obstacle + 1):
		rng.randomize()
		var obstacle_position = Vector2()
		obstacle_position.x = rng.randi_range(-spawn_extends.x + 10, spawn_extends.x - 20)
		obstacle_position.y = rng.randi_range(-spawn_extends.y + 10, spawn_extends.y - 20)

		var new_obstacle = obstacle.instance()
		new_obstacle.position = obstacle_position
		$Spawns.call_deferred("add_child", new_obstacle)

	var exits = get_node_or_null("Exits")
	if exits:
		for exit in exits.get_children():
			exit.connect("body_entered", get_node("/root/BaseLevel"), "_on_exit_entered", [exit])


func _on_InScreen_screen_exited():
	queue_free()


func _on_Victory_body_entered(body):
	PlayerStats.dead = true
	get_tree().quit()
