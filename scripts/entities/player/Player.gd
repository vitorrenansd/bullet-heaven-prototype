class_name Player
extends CharacterBody2D

signal health_depleted

@export var base_stats: BaseStats

var modifiers: Array[StatsModifier] = [] # Lista de modificadores ativos (itens)
var current_health: float
var damage: float
var attack_speed: float
var move_speed: float
var health_regen: int

@onready var movement: PlayerMovement = $PlayerMovement


func _ready() -> void: # Chama quando o obj fica pronto
	recalculate_stats()
	var weapon: Weapon = get_node("Pistol")
	weapon.setup(damage)

func _physics_process(delta: float) -> void:
	movement.tick(delta)

func recalculate_stats() -> void:
	current_health = base_stats.health
	damage = base_stats.damage
	attack_speed = base_stats.attack_speed
	move_speed = base_stats.move_speed
	health_regen = base_stats.health_regen

	for m in modifiers:
		damage *= m.damage_multiplier
		attack_speed *= m.attack_speed_multiplier
		move_speed *= m.move_speed_multiplier
		health_regen += m.bonus_health_regen

func add_modifier(modifier: StatsModifier) -> void: # Add item na run atual do player
	modifiers.append(modifier)
	recalculate_stats()

func take_damage(amount: float) -> void:
	current_health = ceil(current_health - amount)
	if current_health <= 0.0:
		health_depleted.emit()
