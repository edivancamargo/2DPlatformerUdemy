extends Camera2D

export(Color, RGB) var backgroundColor
export(OpenSimplexNoise) var shakeNoise: OpenSimplexNoise

var player: KinematicBody2D
var targetPosition = Vector2.ZERO
var cameraPositionX: int
var cameraPositionY: int

var xNoiseVector := Vector2.RIGHT
var yNoiseVector := Vector2.DOWN
var xNoisePosition := Vector2.ZERO
var yNoisePosition := Vector2.ZERO
var noiseTravelRate: int = 500
var maxShakeOffset: int = 10
var currentShakePercentage: float = 0
var shakeDecay: int = 3

func _ready() -> void:
	VisualServer.set_default_clear_color(backgroundColor)
	SignalServiceManager.connect("apply_camera_shake", self, "on_apply_camera_shake")

func _process(delta) -> void:
#	This is not right, we shouldn't be calling get_tree().get_nodes_in_group for every frame...
	acquire_target_position()
	cameraPositionX = int(lerp(targetPosition.x, global_position.x, pow(2, -15 * delta)))
	cameraPositionY = int(lerp(targetPosition.y, global_position.y, pow(2, -15 * delta)))
	global_position = Vector2(cameraPositionX, cameraPositionY)
	
	if currentShakePercentage > 0:
		xNoisePosition += xNoiseVector * noiseTravelRate * delta
		yNoisePosition += yNoiseVector * noiseTravelRate * delta
		var xSample: float = shakeNoise.get_noise_2d(xNoisePosition.x, xNoisePosition.y)
		var ySample: float = shakeNoise.get_noise_2d(yNoisePosition.x, yNoisePosition.y)
		
		var calculatedOffset = Vector2(xSample, ySample) * maxShakeOffset * pow(currentShakePercentage, 2)
		offset = calculatedOffset
		
		currentShakePercentage = clamp(currentShakePercentage - shakeDecay * delta, 0, 1)

func acquire_target_position() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	if (players.size() > 0):
		player = players[0]
		targetPosition = player.global_position

func on_apply_camera_shake(percentage: float) -> void:
	currentShakePercentage = clamp(currentShakePercentage + percentage, 0, 1)
