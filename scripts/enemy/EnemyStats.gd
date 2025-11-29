class_name EnemyStats
extends Node

# Por enquanto mexer apenas na vida e dano, senão fica muito OP
# Trabalhar na quantidade de inimigos, e não no movespeed impossível ou algo assim

@export var total_health: int
@export var total_damage: float
@export var total_attack_speed: float = 0.75
@export var total_move_speed: float = 200.0
var enemy: Enemy


func _init(e): # Construtor da classe: necessita Enemy
	enemy = e
