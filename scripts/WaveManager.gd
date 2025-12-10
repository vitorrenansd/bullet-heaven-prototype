class_name WaveManager
extends Node2D

@export var current_wave: int = 1
@export var max_wave: int = 20
@export var enemies_per_wave: int = 3
@export var can_start_new_wave = true


func _ready():
	for i in range(10):
		spawn_enemies()

## esse metodo ta feito com a bunda!!!!
## corrigir para depois
func spawn_enemies():
	var evil_skull = preload("res://scenes/characters/enemies/evil_skull.tscn").instantiate()
	%EnemySpawner.progress_ratio = randf() # Escolhe um lugar random da linha de Spawner
	evil_skull.global_position = %EnemySpawner.global_position # Coloca o inimigo la
	add_child(evil_skull)
