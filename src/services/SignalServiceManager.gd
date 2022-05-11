extends Node

signal on_player_hurt

func emit_player_hurt(player: KinematicBody2D) -> void:
	emit_signal("on_player_hurt", player)
