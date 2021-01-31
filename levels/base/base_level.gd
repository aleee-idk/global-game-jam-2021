extends Node2D

var street_x = 1280
var street_y = 1440

var number_streets = 0

var guide_posible_direction = [
	{
		"exit": "Left",
		"animation": "left",
	},
	{
		"exit": "Right",
		"animation": "right",
	},
	{"exit": "Top", "animation": "straight"},
]
var guide_direction

var street = [
	preload("res://levels/base/street/street.tscn"),
	preload("res://levels/base/street/street_triple.tscn"),
]
var victory_street = preload("res://levels/base/street/street_victory.tscn")

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	guide_direction = guide_posible_direction[rng.randi() % guide_posible_direction.size()]


func _on_next_zone_entered(body, prev_zone, direction):
	if ! body.is_in_group("player"):
		return

	if prev_zone.is_in_group("normal_street"):
		var new_street
		# First 2 always normal streets
		if number_streets < 2:
			new_street = street[0].instance()

		# Victory street, only one
		elif number_streets == 3 and PlayerStats.number_of_screens >= PlayerStats.total_screens:
			new_street = victory_street.instance()

		else:
			rng.randomize()
			new_street = street[rng.randi() % street.size()].instance()

		new_street.position.y = prev_zone.position.y - street_y
		$Map.call_deferred("add_child", new_street)
		number_streets += 1
	else:
		var collision_position = body.global_position - direction.global_position
		body.get_node("Camera").limit_top = prev_zone.position.y - street_y / 2
		if collision_position.x < -300:
			body.adjust_rotation(-1)
		elif collision_position.x > 300:
			body.adjust_rotation(1)
