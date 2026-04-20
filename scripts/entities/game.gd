class_name Game
extends Node

@onready var wave_manager: WaveManager = $WaveManager
@onready var player: Player = $Player
@onready var hud: HUDController = $HUDController


func _ready() -> void:
	hud.setup(player)
	player.health_depleted.connect(_on_game_over)
	wave_manager.all_waves_completed.connect(_on_all_waves_completed)
	wave_manager.enemy_spawned.connect(_on_enemy_spawned)

func _on_game_over() -> void:
	print("GAME OVER")
	get_tree().paused = true

func _on_all_waves_completed() -> void:
	print("VOCÊ VENCEU")
	get_tree().paused = true

func _on_enemy_spawned(enemy: Enemy) -> void:
	enemy.died.connect(_on_enemy_died)

func _on_enemy_died(xp_reward: int) -> void:
	player.gain_xp(xp_reward)
