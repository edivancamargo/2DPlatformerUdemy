extends KinematicBody2D

onready var visuals: Node2D = $Visuals

var velocity = Vector2.ZERO
var gravity:int = 1000

func _ready() -> void:
	if velocity.x > 0:
		print("inside")
		visuals.scale = Vector2(-1, 1)

func _process(delta) -> void:
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		velocity.x = lerp(0, velocity.x, pow(2, -1 * delta))
