extends Node

var playerScene = preload("res://src/scenes/Player/Player.tscn")

onready var playerRoot: Node2D = $PlayerRoot
onready var currentPlayer: KinematicBody2D = $PlayerRoot/Player

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
	SignalServiceManager.connect("level_complete", self, "on_level_complete")
	
func coin_collected() -> void:
	collectedCoins += 1
	SignalServiceManager.emit_total_coins_changed(totalCoins, collectedCoins)

func set_totalCoins(newTotal: int) -> void:
	totalCoins = newTotal
	SignalServiceManager.emit_total_coins_changed(totalCoins, collectedCoins)

func register_player(player: KinematicBody2D) -> void:
	currentPlayerNode = player

func create_player() -> void:
	var playerInstance = playerScene.instance()
	playerRoot.add_child(playerInstance)
	playerInstance.global_position = spawnPosition
	register_player(playerInstance)

func on_player_hurt(_playerSignal) -> void:
	currentPlayerNode.queue_free()
	var timer = get_tree().create_timer(1)
	yield(timer, "timeout")
	
	create_player()

func on_level_complete() -> void:
	currentPlayerNode.queue_free()
