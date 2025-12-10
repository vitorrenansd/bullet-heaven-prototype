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

func get_health() -> float:
	return self.health
func set_health(amount: float) -> void:
	self.health = amount

func get_current_health() -> float:
	return self.current_health
func set_current_health(amount: float) -> void:
	self.current_health = amount

func get_damage() -> float:
	return self.damage
func set_damage(amount: float) -> void:
	self.damage = amount

func get_attack_speed() -> float:
	return self.attack_speed

func get_move_speed() -> float:
	return self.move_speed
func set_move_speed(amount: float) -> void:
	self.move_speed = amount

func recalculate_stats() -> void:
	# Primeiro volta aos valores base, dps aplica o bonus da wave atual
	self.set_health(self.enemy.base_stats.get_health())
	self.set_current_health(self.enemy.base_stats.get_health())
	self.set_damage(self.enemy.base_stats.get_damage())
	self.set_move_speed(self.enemy.base_stats.get_move_speed())
	
	## FALTANDO O CALCULO PELO NUMERO DA WAVE
