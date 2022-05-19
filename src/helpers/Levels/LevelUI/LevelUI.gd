extends CanvasLayer

onready var coinsDisplayLbl: Label = $MarginContainer/HBoxContainer/CoinsDisplayLbl

func _ready() -> void:
	SignalServiceManager.connect("total_coins_changed", self, "on_total_coins_changed")

func on_total_coins_changed(totalCoins: int, collectedCoins: int) -> void:
	coinsDisplayLbl.text = str(collectedCoins,"/", totalCoins)
