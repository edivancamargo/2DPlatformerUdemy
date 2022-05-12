extends KinematicBody2D

onready var animatedSprite: AnimatedSprite = $AnimatedSprite
onready var coyoteTimer: Timer = $CoyoteTimer
onready var hurtboxArea: Area2D = $HurtboxArea

var gravity: int = 1000
var velocity: Vector2 = Vector2.ZERO
var maxHorizontalSpeed: int = 140
var horizontalAcceleration: int = 2000
var jumpSpeed: int = 360
var jumpTerminationMultiplier: int = 4
var movePlayerVector: Vector2 = Vector2.ZERO
var hasDoubleJump: bool = false

func _ready() -> void:
	hurtboxArea.connect("area_entered", self, "on_hurtbox_area_entered")

func _process(delta) -> void:
	movePlayerVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movePlayerVector.y = -1 if Input.is_action_just_pressed("jump") else 0
	
	velocity.x += movePlayerVector.x * horizontalAcceleration * delta

	if movePlayerVector.x == 0:
		# https://www.gamedeveloper.com/programming/improved-lerp-smoothing-
		# lerp is frame rate dependent. Doing the way below it fixes it.
		velocity.x = lerp(0, velocity.x, pow(2, -50 * delta))

	velocity.x = clamp(velocity.x, -maxHorizontalSpeed, maxHorizontalSpeed)
	if (movePlayerVector.y < 0 && (is_on_floor() || !coyoteTimer.is_stopped() || hasDoubleJump)):
		velocity.y = movePlayerVector.y * jumpSpeed
		
		if !is_on_floor() && coyoteTimer.is_stopped():
			hasDoubleJump = false
			
		coyoteTimer.stop()

	if (velocity.y < 0 and not Input.is_action_pressed("jump")):
		velocity.y += gravity * jumpTerminationMultiplier * delta	
	else:
		velocity.y += gravity * delta

	var wasOnFloor = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if wasOnFloor && !is_on_floor():
		coyoteTimer.start()
	
	if is_on_floor():
		hasDoubleJump = true
	
	update_animation()

func update_animation() -> void:
	if not is_on_floor():
		animatedSprite.play("Jump")
	elif movePlayerVector.x != 0:
		animatedSprite.play("Run")
	else:
		animatedSprite.play("Idle")

	if movePlayerVector.x != 0:
		animatedSprite.flip_h = true if movePlayerVector.x > 0 else false

func on_hurtbox_area_entered(_area2d) -> void:
	SignalServiceManager.emit_player_hurt(self)

