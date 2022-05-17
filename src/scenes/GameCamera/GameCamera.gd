extends Camera2D

export(Color, RGB) var backgroundColor
var player: KinematicBody2D
var targetPosition = Vector2.ZERO
var cameraPositionX: int
var cameraPositionY: int

func _ready() -> void:
	VisualServer.set_default_clear_color(backgroundColor)

func _process(delta) -> void:
#	This is not right, we shouldn't be calling get_tree().get_nodes_in_group for every frame...
	acquire_target_position()
	cameraPositionX = int(lerp(player.global_position.x, global_position.x, pow(2, -15 * delta)))
	cameraPositionY = int(lerp(player.global_position.y, global_position.y, pow(2, -15 * delta)))
	global_position = Vector2(cameraPositionX, cameraPositionY)

func acquire_target_position() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	if (players.size() > 0):
		player = players[0]
		targetPosition = player.global_position
