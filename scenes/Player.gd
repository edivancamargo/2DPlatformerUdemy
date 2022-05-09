extends KinematicBody2D

var gravity: int = 400
var velocity: Vector2 = Vector2.ZERO
var maxHorizontalSpeed: int = 100
var jumpSpeed: int = 180
var movePlayerVector: Vector2 = Vector2.ZERO

func _process(delta) -> void:
	velocity.x = movePlayerVector.x * maxHorizontalSpeed
	
	if (movePlayerVector.y < 0 and is_on_floor()):
		velocity.y = movePlayerVector.y * jumpSpeed
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _input(event):
	movePlayerVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movePlayerVector.y = -1 if Input.is_action_just_pressed("jump") else 0
