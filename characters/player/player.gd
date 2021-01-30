extends KinematicBody2D

export var vertical_speed = 400
export var horizontal_speed = 600
export var aceleration = 1

export var speed_variation = 50
export var speed_rotation = 10

var velocity = Vector2()
var direction = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func _process(delta):
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if Input.is_action_just_pressed("ui_page_up"):
		adjust_speed(1)
	if Input.is_action_just_pressed("ui_page_down"):
		adjust_speed(-1)

	var collision = move_and_collide(velocity * delta)


func move():
	velocity.x = lerp(velocity.x, direction.x * horizontal_speed, aceleration)
	velocity.y = lerp(velocity.y, -1 * vertical_speed, aceleration)


func adjust_speed(value):
	vertical_speed += speed_variation * value


func adjust_rotation(value):
	rotation += value * speed_rotation
