class_name Player
extends CharacterBody2D

signal health_depleted
signal health_changed(current: float, maximum: float)
signal xp_changed(current_xp: int, xp_to_next_level: int)
signal level_up(new_level: int)

@export var base_stats: BaseStats

var modifiers: Array[StatsModifier] = [] # Lista de modificadores ativos (itens)
var current_weapon: Weapon

var max_health: float
var current_health: float
var damage: float
var attack_speed: float
var move_speed: float
var health_regen: int

var current_xp: int = 0
var level: int = 1
var xp_to_next_level: int = 100 # base, o valor escala

var _regen_timer: float = 0.0
const REGEN_INTERVAL: float = 10.0

@onready var movement: PlayerMovement = $PlayerMovement
@onready var weapon_range: Area2D = $WeaponRange


func _ready() -> void:
	base_stats = GlobalRunConfig.selected_class
	max_health = base_stats.health
	current_health = max_health
	recalculate_stats()
	current_weapon = GlobalRunConfig.selected_weapon_scene.instantiate()
	add_child(current_weapon)
	current_weapon.setup(damage, attack_speed, weapon_range)

func _physics_process(delta: float) -> void:
	movement.tick(delta)

func _process(delta: float) -> void:
	if health_regen <= 0 or current_health >= max_health:
		return
		
	_regen_timer += delta
	if _regen_timer >= REGEN_INTERVAL:
		_regen_timer = 0.0
		current_health = minf(current_health + health_regen, max_health)
		health_changed.emit(current_health, max_health)


func recalculate_stats() -> void:
	max_health = base_stats.health
	damage = base_stats.damage
	attack_speed = base_stats.attack_speed
	move_speed = base_stats.move_speed
	health_regen = base_stats.health_regen

	for m in modifiers:
		damage *= m.damage_multiplier
		attack_speed *= m.attack_speed_multiplier
		move_speed *= m.move_speed_multiplier
		health_regen += m.bonus_health_regen
		max_health += m.bonus_health

	if current_weapon:
		current_weapon.setup(damage, attack_speed, weapon_range)
	health_changed.emit(current_health, max_health)

func add_modifier(modifier: StatsModifier) -> void: # Add item na run atual do player
	modifiers.append(modifier)
	var old_max := max_health
	recalculate_stats()
	current_health += max_health - old_max
	health_changed.emit(current_health, max_health)

func take_damage(amount: float) -> void:
	current_health = ceil(current_health - amount)
	health_changed.emit(current_health, max_health)
	if current_health <= 0.0:
		health_depleted.emit()

func gain_xp(amount: int) -> void:
	var multiplied_xp := int(amount * _get_xp_multiplier())
	current_xp += multiplied_xp
	xp_changed.emit(current_xp, xp_to_next_level)
	if current_xp >= xp_to_next_level:
		_level_up()

func _get_xp_multiplier() -> float:
	var multiplier := 1.0
	for m in modifiers:
		multiplier *= m.xp_multiplier
	return multiplier

func _level_up() -> void:
	current_xp -= xp_to_next_level
	level += 1
	xp_to_next_level = int(xp_to_next_level * 1.5)
	level_up.emit(level)
	xp_changed.emit(current_xp, xp_to_next_level)
