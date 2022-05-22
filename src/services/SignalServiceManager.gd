extends Node

signal player_hurt
signal coin_collected
signal total_coins_changed
signal level_complete
signal start_next_level
signal all_levels_cleared

func emit_player_hurt(player: KinematicBody2D) -> void:
	emit_signal("player_hurt", player)

func emit_coin_collected() -> void:
	emit_signal("coin_collected")

func emit_total_coins_changed(totalCoins: int, collectedCoins: int) -> void:
	emit_signal("total_coins_changed", totalCoins, collectedCoins)

func emit_level_complete() -> void:
	emit_signal("level_complete")

func emit_start_next_level() -> void:
	emit_signal("start_next_level")

func emit_all_levels_cleared() -> void:
	print("You have finished all levels, congratulations!")
	emit_signal("all_levels_cleared")
