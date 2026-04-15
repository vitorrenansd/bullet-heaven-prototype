class_name WaveManager
extends Node2D

signal wave_started(wave_number: int)
signal wave_completed(wave_number: int)
signal all_waves_completed

@export var enemy_scene: PackedScene
@export var spawn_path_node: Path2D
@export var spawn_path_follow: PathFollow2D
@export var player: Player

@export var current_wave: int = 1
@export var max_waves: int = 20
@export var enemies_per_wave: int = 3
@export var enemies_per_wave_increment: int = 2
@export var spawn_interval: float = 0.5
@export var between_waves_interval: float = 2.0

var _enemies_alive: int = 0
var _enemies_to_spawn: int = 0


func _ready() -> void:
	spawn_path_node.global_position = player.global_position
	start_wave()

func _process(_delta: float) -> void:
	# mantém o path centrado no player para spawns sempre fora da tela
	spawn_path_node.global_position = player.global_position

func start_wave() -> void:
	_enemies_to_spawn = enemies_per_wave + (current_wave - 1) * enemies_per_wave_increment
	_enemies_alive = _enemies_to_spawn
	wave_started.emit(current_wave)
	print("WAVE: ", current_wave)
	_spawn_next_enemy()

func _spawn_next_enemy() -> void:
	if _enemies_to_spawn <= 0:
		return

	spawn_path_follow.progress_ratio = randf()
	var spawn_position := spawn_path_follow.global_position

	# posição definida após add_child para respeitar o espaço global
	var enemy: Enemy = enemy_scene.instantiate()
	get_tree().current_scene.add_child(enemy)
	enemy.global_position = spawn_position
	enemy.died.connect(_on_enemy_died)

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
	# aguarda antes de iniciar a próxima wave. sons e efeitos futuros
	await get_tree().create_timer(between_waves_interval).timeout
	start_wave()


func _on_player_health_depleted() -> void:
	print("GAME OVER")
	get_tree().paused = true
