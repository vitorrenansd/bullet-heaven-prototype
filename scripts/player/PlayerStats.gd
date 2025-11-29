class_name PlayerStats
extends Node

@export var total_health: int
@export var total_damage: float
@export var total_attack_speed: float
@export var total_move_speed: float
var player: Player


func _init(p): # Construtor da classe: necessita Player
	player = p

func recalculate_stats() -> void:
	# Primeiro volta aos valores base, dps aplica todos os modificadores ativos
	total_health = player.base_stats.health
	total_damage = player.base_stats.damage
	total_attack_speed = player.base_stats.attack_speed
	total_move_speed = player.base_stats.move_speed
	
	for m in player.modifiers:
		total_health += m.bonus_health
		total_damage *= m.damage_multiplier
		total_attack_speed *= m.attack_speed_multiplier
		total_move_speed *= m.move_speed_multiplier
