extends KinematicBody2D

var enemyDeathScene = preload("res://src/scenes/Enemy/EnemyDeath.tscn")

enum Direction {RIGHT, LEFT}
export(Direction) var initialDirection
export var isSpawning: bool = false

onready var animatedSprite: AnimatedSprite = $Visuals/AnimatedSprite

var startDirection: Vector2 = Vector2.ZERO
var maxSpeed: int = 25
var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
var gravity: int = 500

func _ready() -> void:
	set_enemy_direction()
	$GoalDetector.connect("area_entered", self, "on_goal_entered")
	$HurtBox.connect("area_entered", self, "on_hurtbox_entered")

func _process(delta) -> void:
	if isSpawning:
		return
	
	velocity.x = (direction * maxSpeed).x
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	animatedSprite.flip_h = true if direction.x > 0 else false

func set_enemy_direction() -> void:
	if startDirection != Vector2.ZERO:
		direction = startDirection
	else:
		direction = Vector2.RIGHT if initialDirection == Direction.RIGHT else Vector2.LEFT

func on_goal_entered(_area2D: Area2D) -> void:
	direction *= -1

func kill() -> void:
	var deathInstance = enemyDeathScene.instance()
	get_parent().add_child(deathInstance)
	deathInstance.global_position = global_position
	
#	If travelling to the right
	if velocity.x > 0:
#		Flip the sprite to the correct side.
		deathInstance.scale = Vector2(-1, 1)
	
	queue_free()

func on_hurtbox_entered(_area2D: Area2D) -> void:
	SignalServiceManager.emit_apply_camera_shake(2.25)
	call_deferred("kill")
