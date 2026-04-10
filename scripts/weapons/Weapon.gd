class_name Weapon
extends Area2D

@export var shooting_point: Marker2D

const BULLET = preload("res://scripts/weapons/bullets/pistol_bullet.tscn")

var attack_speed: float
var damage: float

@onready var shoot_timer: Timer = $ShootTimer


func setup(p_attack_speed: float, p_damage: float) -> void:
	attack_speed = p_attack_speed
	damage = p_damage
	shoot_timer.wait_time = 1.0 / attack_speed
	shoot_timer.one_shot = true
	shoot_timer.autostart = false

func _physics_process(_delta: float) -> void:
	lock_n_load()

func ready_to_shoot() -> bool:
	return shoot_timer.is_stopped()

func lock_n_load() -> void: # Função que locka e atira no inimigo mais proximo
	var enemies_in_range := get_overlapping_bodies()
	if enemies_in_range.is_empty() or not ready_to_shoot():
		return
	
	# Encontra o inimigo mais proximo
	var nearest_enemy := enemies_in_range[0]
	var nearest_dist := global_position.distance_squared_to(nearest_enemy.global_position)
	for enemy in enemies_in_range:
		var dist := global_position.distance_squared_to(enemy.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest_enemy = enemy
	
	# Mira e atira
	look_at(nearest_enemy.global_position)
	fire()

func fire() -> void:
	var new_bullet := BULLET.instantiate()
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	new_bullet.damage = damage
	get_tree().current_scene.add_child(new_bullet)
	# Reseta cooldown
	shoot_timer.start()
