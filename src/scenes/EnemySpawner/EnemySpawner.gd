extends Position2D

enum Direction {RIGHT, LEFT}

export(PackedScene) var enemyScene
export(Direction) var startDirection

var currentEnemyNode = null
var spawnOnNextTick = false

func _ready() -> void:
	$Timer.connect("timeout", self, "on_spawn_timer_timeout")
	call_deferred("spawn_enemy")
	
func spawn_enemy() -> void:
	currentEnemyNode = enemyScene.instance()
	currentEnemyNode.startDirection = Vector2.RIGHT if startDirection == Direction.RIGHT else Vector2.LEFT
	currentEnemyNode.global_position = global_position
	get_parent().add_child(currentEnemyNode)

func on_spawn_timer_timeout() -> void:
	check_enemy_spawn()

func check_enemy_spawn() -> void:
	if !is_instance_valid(currentEnemyNode):
		if spawnOnNextTick:
			spawn_enemy()
			spawnOnNextTick = false
		else:
			spawnOnNextTick = true
