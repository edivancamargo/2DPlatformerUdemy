extends Node

var playerScene = preload("res://src/scenes/Player/Player.tscn")
var spawnPosition = Vector2.ZERO
onready var currentPlayer: KinematicBody2D = $Player
var currentPlayerNode: KinematicBody2D = null

func _ready() -> void:
	spawnPosition = currentPlayer.global_position
	SignalServiceManager.connect("player_hurt", self, "on_player_hurt", [], CONNECT_DEFERRED)
	register_player(currentPlayer)
	
func register_player(player: KinematicBody2D) -> void:
	currentPlayerNode = player

func create_player() -> void:
	var playerInstance = playerScene.instance()
	add_child_below_node(currentPlayerNode, playerInstance)
	playerInstance.global_position = spawnPosition
	register_player(playerInstance)

func on_player_hurt(_playerSignal) -> void:
	currentPlayerNode.queue_free()
	create_player()
