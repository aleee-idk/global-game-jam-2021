extends KinematicBody2D

export var speed = 400
var velocity = Vector2()


func _process(delta):
	velocity.y = lerp(velocity.y, -speed, 1)
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider.has_method("game_over"):
		collision.collider.game_over()
