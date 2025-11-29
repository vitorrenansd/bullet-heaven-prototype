class_name Player
extends CharacterBody2D

@export var base_stats: WarriorBaseStats # Atualmente usando os stats do Warrior
var modifiers: Array[StatsModifier] = [] # Lista de modificadores ativos (itens? livros?)
var final_health: int
var final_damage: float
var final_attack_speed: float
var final_move_speed: float


func _ready():
	_recalculate_stats()

# Adiciona um novo modificador ao personagem (item? livro?)
func add_modifier(modifier: StatsModifier) -> void:
	modifiers.append(modifier)
	_recalculate_stats()

# Recalcula todos os atributos baseado nos stats base + modificadores
func _recalculate_stats() -> void:
	# Primeiro volta aos valores base
	final_health = base_stats.health
	final_damage = base_stats.damage
	final_attack_speed = base_stats.attack_speed
	final_move_speed = base_stats.move_speed
	
	# Aplica todos os modificadores ativos
	for m in modifiers:
		final_health += m.bonus_health
		final_damage *= m.damage_multiplier
		final_attack_speed *= m.attack_speed_multiplier
		final_move_speed *= m.move_speed_multiplier
