extends KinematicBody2D

enum Direction {RIGHT, LEFT}
export(Direction) var initialDirection

var maxSpeed: int = 25
var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
var gravity: int = 500
onready var animatedSprite: AnimatedSprite = $AnimatedSprite

func _ready() -> void:
	direction = Vector2.RIGHT if initialDirection == Direction.RIGHT else Vector2.LEFT
	$GoalDetector.connect("area_entered", self, "on_goal_entered")
	$HurtBox.connect("area_entered", self, "on_hurtbox_entered")

func _process(delta) -> void:
	velocity.x = (direction * maxSpeed).x
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	animatedSprite.flip_h = true if direction.x > 0 else false
	
func on_goal_entered(_area2D: Area2D) -> void:
	direction *= -1

func on_hurtbox_entered(_area2D: Area2D) -> void:
	queue_free()
