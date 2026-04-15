class_name Enemy
extends CharacterBody2D

signal died

@export var base_stats: BaseStats

var current_health: float
var can_attack: bool = true
var _is_dead: bool = false


func _ready() -> void:
	current_health = base_stats.health

func attack(player: Player) -> void:
	if not can_attack:
		return
		
	can_attack = false
	player.take_damage(base_stats.damage)
	await get_tree().create_timer(base_stats.attack_speed).timeout
	can_attack = true

func take_damage(amount: float) -> void:
	if _is_dead:
		return
	current_health = ceil(current_health - amount)
	if current_health <= 0:
		_is_dead = true
		died.emit()
		queue_free()
