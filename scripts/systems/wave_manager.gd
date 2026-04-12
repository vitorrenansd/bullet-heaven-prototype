class_name WaveManager
extends Node2D

signal wave_started(wave_number: int)
signal wave_completed(wave_number: int)
signal all_waves_completed

@export var enemy_scene: PackedScene
@export var spawn_path: PathFollow2D

@export var current_wave: int = 1
@export var max_waves: int = 20
@export var enemies_per_wave: int = 3
@export var enemies_per_wave_increment: int = 2  # quantos inimigos adicionais por wave
@export var spawn_interval: float = 0.5          # intervalo entre spawns
@export var between_waves_interval: float = 2.0  # pausa entre waves

var _enemies_alive: int = 0
var _enemies_to_spawn: int = 0
var _spawning: bool = false


func _ready() -> void:
	start_wave()


func start_wave() -> void:
	_enemies_to_spawn = enemies_per_wave + (current_wave - 1) * enemies_per_wave_increment
	_enemies_alive = _enemies_to_spawn
	wave_started.emit(current_wave)
	_spawn_next_enemy()


func _spawn_next_enemy() -> void:
	if _enemies_to_spawn <= 0:
		return

	var enemy: Enemy = enemy_scene.instantiate()
	spawn_path.progress_ratio = randf()
	enemy.global_position = spawn_path.global_position
	enemy.died.connect(_on_enemy_died)
	add_child(enemy)

	_enemies_to_spawn -= 1

	if _enemies_to_spawn > 0:
		await get_tree().create_timer(spawn_interval).timeout
		_spawn_next_enemy()


func _on_enemy_died() -> void:
	_enemies_alive -= 1
	if _enemies_alive <= 0:
		_on_wave_cleared()


func _on_wave_cleared() -> void:
	wave_completed.emit(current_wave)

	if current_wave >= max_waves:
		all_waves_completed.emit()
		return

	current_wave += 1
	await get_tree().create_timer(between_waves_interval).timeout
	start_wave()
