class_name EnemyStats
extends Node

# Por enquanto não mexer no atkspd, senão fica muito OP
@export var total_health: int
@export var total_damage: float
@export var total_attack_speed: float = 0.75
@export var total_move_speed: float
var enemy: Enemy


func _init(e): # Construtor da classe: necessita Enemy
	enemy = e

func recalculate_stats() -> void:
	# Primeiro volta aos valores base, dps aplica o bonus da wave atual
	total_health = enemy.base_stats.health
	total_damage = enemy.base_stats.damage
	total_move_speed = enemy.base_stats.move_speed
	
	## FALTANDO O CALCULO PELO NUMERO DA WAVE
