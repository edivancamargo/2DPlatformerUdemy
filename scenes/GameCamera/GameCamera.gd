extends Camera2D

export(Color, RGB) var backgroundColor

onready var players = get_tree().get_nodes_in_group("Player")

var player: KinematicBody2D = null
var cameraPositionX: int
var cameraPositionY: int

func _ready() -> void:
	set_player()
	VisualServer.set_default_clear_color(backgroundColor)

func _process(delta) -> void:
	cameraPositionX = int(lerp(player.global_position.x, global_position.x, pow(2, -15 * delta)))
	cameraPositionY = int(lerp(player.global_position.y, global_position.y, pow(2, -15 * delta)))
	global_position = Vector2(cameraPositionX, cameraPositionY)

func set_player() -> void:
	if players.size() > 0:
		player = players[0] as KinematicBody2D
