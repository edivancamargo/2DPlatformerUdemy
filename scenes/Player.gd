extends KinematicBody2D

var gravity: int = 1000
var velocity: Vector2 = Vector2.ZERO
var maxHorizontalSpeed: int = 125
var horizontalAcceleration: int = 2000
var jumpSpeed: int = 320
var movePlayerVector: Vector2 = Vector2.ZERO

func _process(delta) -> void:
	velocity.x += movePlayerVector.x * horizontalAcceleration * delta
	
	if movePlayerVector.x == 0:
		# https://www.gamedeveloper.com/programming/improved-lerp-smoothing-
		# lerp is frame rate dependent. Doing the way below it fixes it.
		velocity.x = lerp(0, velocity.x, pow(2, -50 * delta))
	
	velocity.x = clamp(velocity.x, -maxHorizontalSpeed, maxHorizontalSpeed)
	
	if (movePlayerVector.y < 0 and is_on_floor()):
		velocity.y = movePlayerVector.y * jumpSpeed
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _input(event):
	movePlayerVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movePlayerVector.y = -1 if Input.is_action_just_pressed("jump") else 0
