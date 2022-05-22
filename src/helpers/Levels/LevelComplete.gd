extends CanvasLayer

onready var nextLevelBtn = $MarginContainer/VBoxContainer/Button

func _ready() -> void:
	nextLevelBtn.connect("pressed", self, "on_next_level_pressed")

func on_next_level_pressed() -> void:
	self.queue_free()
	SignalServiceManager.emit_start_next_level()
