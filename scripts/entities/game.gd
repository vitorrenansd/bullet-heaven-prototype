class_name Game
extends Node

@onready var wave_manager: WaveManager = $WaveManager
@onready var player: Player = $Player


func _ready() -> void:
	player.health_depleted.connect(_on_game_over)
	wave_manager.all_waves_completed.connect(_on_all_waves_completed)


func _on_game_over() -> void:
	print("GAME OVER")
	get_tree().paused = true


func _on_all_waves_completed() -> void:
	print("VOCÊ VENCEU")
	get_tree().paused = true
