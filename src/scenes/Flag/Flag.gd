extends Node2D

onready var collisionArea = $Area2D

func _ready() -> void:
	collisionArea.connect("area_entered", self, "on_area_entered")

func on_area_entered(_area: Area2D) -> void:
	SignalServiceManager.emit_level_complete()
