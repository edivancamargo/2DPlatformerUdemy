extends Node

var playerScene = preload("res://src/scenes/Player/Player.tscn")

onready var currentPlayer: KinematicBody2D = $Player

var spawnPosition = Vector2.ZERO
var currentPlayerNode: KinematicBody2D = null
var totalCoins: int = 0 setget set_totalCoins
var collectedCoins: int = 0

func _ready() -> void:
	spawnPosition = currentPlayer.global_position
	connect_default_signals()
	register_player(currentPlayer)
	self.totalCoins = get_tree().get_nodes_in_group("Coin").size()
	
func connect_default_signals() -> void:
	SignalServiceManager.connect("player_hurt", self, "on_player_hurt", [], CONNECT_DEFERRED)
	SignalServiceManager.connect("coin_collected", self, "coin_collected")
	
func coin_collected() -> void:
	collectedCoins += 1
	print(str(totalCoins), " - ",str(collectedCoins))
	SignalServiceManager.emit_total_coins_changed(totalCoins, collectedCoins)

func set_totalCoins(newTotal: int) -> void:
	totalCoins = newTotal
	print("total coins: ", str(totalCoins))
	SignalServiceManager.emit_total_coins_changed(totalCoins, collectedCoins)

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
