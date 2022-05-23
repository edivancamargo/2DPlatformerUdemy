extends Node

export(Array, PackedScene) var levelScenes
var levelCompleteScene: PackedScene = preload("res://src/helpers/Levels/LevelComplete.tscn")

var currentLevelIndex: int = 0

func _ready() -> void:
	SignalServiceManager.connect("level_complete", self, "on_level_complete")
	SignalServiceManager.connect("start_next_level", self, "on_start_next_level")
	
func change_level(levelIndex: int) -> void:
	currentLevelIndex = levelIndex
	if currentLevelIndex >= levelScenes.size():
		SignalServiceManager.emit_all_levels_cleared()
#		Restart the game from first level for now...
		change_level(0)
	else:
		get_tree().change_scene(levelScenes[currentLevelIndex].resource_path)

func on_level_complete() -> void:
	var levelComplete = levelCompleteScene.instance()
	add_child(levelComplete)

func on_start_next_level() -> void:
	change_level(currentLevelIndex + 1)
