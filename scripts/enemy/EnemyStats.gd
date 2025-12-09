class_name EnemyStats
extends Node

# Por enquanto não mexer no atkspd, senão fica muito OP
@export var health: float
@export var current_health: float
@export var damage: float
@export var attack_speed: float = 1.0
@export var move_speed: float
var enemy: Enemy


func _init(e): # Construtor da classe: necessita Enemy
	self.enemy = e

func recalculate_stats() -> void:
	# Primeiro volta aos valores base, dps aplica o bonus da wave atual
	self.health = self.enemy.base_stats.health
	self.current_health = self.enemy.base_stats.health
	self.damage = self.enemy.base_stats.damage
	self.move_speed = self.enemy.base_stats.move_speed
	
	## FALTANDO O CALCULO PELO NUMERO DA WAVE
