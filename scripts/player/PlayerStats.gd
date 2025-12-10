class_name PlayerStats
extends Node

@export var health: float
@export var current_health: float
@export var damage: float
@export var attack_speed: float
@export var move_speed: float
@export var health_regen: int
var player: Player


func _init(p): # Construtor da classe: necessita Player
	self.player = p

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
func set_attack_speed(amount: float) -> void:
	self.attack_speed = amount

func get_move_speed() -> float:
	return self.move_speed
func set_move_speed(amount: float) -> void:
	self.move_speed = amount

func get_health_regen() -> int:
	return self.health_regen
func set_health_regen(amount: int) -> void:
	self.health_regen = amount

func recalculate_stats() -> void:
	# Primeiro volta aos valores base, dps aplica todos os modificadores ativos
	self.set_health(self.player.base_stats.get_health())
	self.set_damage(self.player.base_stats.get_damage())
	self.set_attack_speed(self.player.base_stats.get_attack_speed())
	self.set_move_speed(self.player.base_stats.get_move_speed())
	self.set_health_regen(self.player.base_stats.get_health_regen())
	
	for m in self.player.modifiers:
		self.set_health(get_health() + m.bonus_health)
		self.set_damage(get_damage() * m.damage_multiplier)
		self.set_attack_speed(get_attack_speed() * m.attack_speed_multiplier)
		self.set_move_speed(get_move_speed() * m.move_speed_multiplier)
		self.set_health_regen(get_health_regen() + m.bonus_health_regen)
