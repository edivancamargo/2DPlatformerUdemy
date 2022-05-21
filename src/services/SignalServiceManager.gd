extends Node

signal player_hurt
signal coin_collected
signal total_coins_changed
signal level_cleared
signal all_levels_cleared

func emit_player_hurt(player: KinematicBody2D) -> void:
	emit_signal("player_hurt", player)

func emit_level_cleared() -> void:
	emit_signal("level_cleared")

func emit_coin_collected() -> void:
	emit_signal("coin_collected")

func emit_total_coins_changed(totalCoins: int, collectedCoins: int) -> void:
	emit_signal("total_coins_changed", totalCoins, collectedCoins)

func emit_all_levels_cleared() -> void:
	print("You have finished all levels, congratulations!")
	emit_signal("all_levels_cleared")
