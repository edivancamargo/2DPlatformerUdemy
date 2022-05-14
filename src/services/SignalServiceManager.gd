extends Node

signal player_hurt

func emit_player_hurt(player: KinematicBody2D) -> void:
	emit_signal("player_hurt", player)
