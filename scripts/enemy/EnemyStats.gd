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
