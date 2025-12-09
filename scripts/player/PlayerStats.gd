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

func recalculate_stats() -> void:
	# Primeiro volta aos valores base, dps aplica todos os modificadores ativos
	self.health = self.player.base_stats.health
	self.damage = self.player.base_stats.damage
	self.attack_speed = self.player.base_stats.attack_speed
	self.move_speed = self.player.base_stats.move_speed
	self.health_regen = self.player.base_stats.health_regen
	
	for m in self.player.modifiers:
		self.health += m.bonus_health
		self.damage *= m.damage_multiplier
		self.attack_speed *= m.attack_speed_multiplier
		self.move_speed *= m.move_speed_multiplier
