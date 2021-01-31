extends KinematicBody2D

export var aceleration = 1
export var friction = 0.1

export var speed_variation = 50
export var speed_rotation = 90

var velocity = Vector2()
var direction = Vector2()

onready var states = $StateMachine
onready var overlay = $UI/Control/ColorRect
onready var speed_label = $UI/Control/Speed
onready var tween = $Tween
onready var level = get_node("/root/BaseLevel")


# Called when the node enters the scene tree for the first time.
func _ready():
	tween.interpolate_property(
		overlay, "color", overlay.color, Color(0, 0, 0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")


func _process(_delta):
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	velocity = move_and_slide(velocity)
	speed_label.set_text(str(PlayerStats.vertical_speed) + " Speed")


func _input(event):
	if event.is_action_pressed("ui_accept"):
		$Guide.play(level.guide_direction["animation"])
		adjust_speed(-1)
		yield($Guide, "animation_finished")
		$Guide.play("none")


func move():
	velocity = Vector2(direction.x * PlayerStats.horizontal_speed, -1 * PlayerStats.vertical_speed).rotated(
		rotation
	)


func adjust_speed(value):
	PlayerStats.vertical_speed += (speed_variation * value) if PlayerStats.vertical_speed > 0 else 0


func adjust_rotation(value):
	var speed_aux = PlayerStats.vertical_speed
	PlayerStats.vertical_speed = 250
	tween.interpolate_property(
		self,
		"rotation_degrees",
		rotation,
		speed_rotation * value,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
	PlayerStats.vertical_speed = speed_aux


func _on_VisibilityNotifier2D_screen_exited():
	var origin = level.get_node("Map").get_child(0).get_node("Position2D")
	var exit_direction = global_position.direction_to(origin.global_position).sign()
	if exit_direction.y > 0:
		exit_direction = "Top"
	elif exit_direction.x > 0:
		exit_direction = "Right"
	else:
		exit_direction = "Left"

	if level.guide_direction["exit"] != exit_direction:
		PlayerStats.incorrect_exit = true
	tween.interpolate_property(
		overlay, "color", overlay.color, Color(0, 0, 0, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
	get_tree().reload_current_scene()


func game_over():
	get_tree().quit()
