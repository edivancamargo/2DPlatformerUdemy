extends Node2D

onready var area2D: Area2D = $Area2D
onready var area2DCollision: CollisionShape2D = $Area2D/CollisionShape2D
onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	area2D.connect("area_entered", self, "on_area_entered")

func on_area_entered(_area2d):
	animationPlayer.play("Pickup")
	call_deferred("disable_pickup")

func disable_pickup() -> void:
	area2DCollision.disabled = true
