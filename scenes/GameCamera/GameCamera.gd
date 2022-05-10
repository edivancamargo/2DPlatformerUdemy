extends Camera2D

export(Color, RGB) var backgroundColor

onready var players = get_tree().get_nodes_in_group("Player")
var player = null
var targetPosition := Vector2.ZERO

func _ready() -> void:
	VisualServer.set_default_clear_color(backgroundColor)

func _process(delta) -> void:
	get_target_position()
	global_position = lerp(targetPosition, global_position, pow(2, -50 * delta))

func get_target_position() -> Vector2:
	if players.size() > 0:
		player = players[0]
		targetPosition = player.global_position
	
	return targetPosition
