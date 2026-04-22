class_name Game
extends Node

@onready var wave_manager: WaveManager = $WaveManager
@onready var player: Player = $Player
@onready var hud: HUDController = $HUDController
@onready var upgrade_system: UpgradeSystem = $UpgradeSystem
@onready var upgrade_menu: UpgradeMenu = $UpgradeMenu


func _ready() -> void:
	hud.setup(player)
	player.health_depleted.connect(_on_game_over)
	player.level_up.connect(_on_level_up)
	wave_manager.all_waves_completed.connect(_on_all_waves_completed)
	wave_manager.enemy_spawned.connect(_on_enemy_spawned)
	upgrade_system.upgrades_rolled.connect(upgrade_menu.show_upgrades)
	upgrade_menu.upgrade_chosen.connect(_on_upgrade_chosen)

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

func _on_level_up(_new_level: int) -> void:
	upgrade_system.roll()

func _on_upgrade_chosen(modifier: StatsModifier) -> void:
	player.add_modifier(modifier)
