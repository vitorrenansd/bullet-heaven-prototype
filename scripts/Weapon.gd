class_name Weapon
extends Area2D

@export var shooting_point: Marker2D
const BULLET = preload("res://scenes/weapons/bullet.tscn")
var current_stats: PlayerStats
@onready var shoot_timer: Timer = $ShootTimer


func setup(ps: PlayerStats):
	self.current_stats = ps
	self.shoot_timer.wait_time = 1.0 / self.current_stats.attack_speed
	self.shoot_timer.one_shot = true
	self.shoot_timer.autostart = false 

func _physics_process(_delta):
	lock_n_load()

func ready_to_shoot() -> bool:
	return shoot_timer.is_stopped()

func lock_n_load() -> void:  ## Função que locka e atira no inimigo mais proximo
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0 and ready_to_shoot():
		var nearest_enemy = enemies_in_range[0]
		look_at(nearest_enemy.global_position)
		fire()

func fire() -> void:
	var new_bullet = self.BULLET.instantiate()
	new_bullet.global_position = self.shooting_point.global_position
	new_bullet.global_rotation = self.shooting_point.global_rotation
	get_tree().current_scene.add_child(new_bullet)
	shoot_timer.start() ## Reseta cooldown
