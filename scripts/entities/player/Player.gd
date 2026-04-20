class_name Player
extends CharacterBody2D

signal health_depleted
signal health_changed(current: float, maximum: float)
signal xp_changed(current_xp: int, xp_to_next_level: int)
signal level_up(new_level: int)

@export var base_stats: BaseStats

var modifiers: Array[StatsModifier] = [] # Lista de modificadores ativos (itens)
var current_health: float
var damage: float
var attack_speed: float
var move_speed: float
var health_regen: int

var current_xp: int = 0
var level: int = 1
var xp_to_next_level: int = 100 # base, o valor escala

@onready var movement: PlayerMovement = $PlayerMovement
@onready var weapon_range: Area2D = $WeaponRange


func _ready() -> void: # Chama quando o obj fica pronto
	recalculate_stats()
	var weapon: Weapon = get_node("Pistol")
	weapon.setup(damage, weapon_range)

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
	health_changed.emit(current_health, base_stats.health)
	if current_health <= 0.0:
		health_depleted.emit()

func gain_xp(amount: int) -> void:
	current_xp += amount
	xp_changed.emit(current_xp, xp_to_next_level)
	if current_xp >= xp_to_next_level:
		_level_up()

func _level_up() -> void:
	current_xp -= xp_to_next_level
	level += 1
	xp_to_next_level = int(xp_to_next_level * 1.5)
	level_up.emit(level)
	xp_changed.emit(current_xp, xp_to_next_level)
