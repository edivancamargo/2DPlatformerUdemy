extends Node

export(Array, PackedScene) var levelScenes

var currentLevelIndex: int = 0

func _ready() -> void:
	SignalServiceManager.connect("level_cleared", self, "on_level_cleared")
	change_level(currentLevelIndex)
	
func change_level(levelIndex: int) -> void:
	currentLevelIndex = levelIndex
	if currentLevelIndex >= levelScenes.size():
		SignalServiceManager.emit_all_levels_cleared()
#		Restart the game from first level for now...
		change_level(0)
	else:
		get_tree().change_scene(levelScenes[currentLevelIndex].resource_path)

func on_level_cleared() -> void:
	change_level(currentLevelIndex + 1)
