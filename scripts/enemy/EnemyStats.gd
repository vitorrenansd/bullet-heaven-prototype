class_name EnemyStats
extends Node

# Por enquanto mexer apenas na vida e dano, senão fica muito OP
# Trabalhar na quantidade, e não no movespeed impossível ou algo assim

@export var total_health: int
@export var total_damage: float
var enemy: Enemy


func _init(e): # Construtor da classe: necessita Player
	enemy = e
