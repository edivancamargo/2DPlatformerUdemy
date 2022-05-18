extends Node

signal player_hurt
signal level_cleared

func emit_player_hurt(player: KinematicBody2D) -> void:
	emit_signal("player_hurt", player)

func emit_level_cleared() -> void:
	emit_signal("level_cleared")
