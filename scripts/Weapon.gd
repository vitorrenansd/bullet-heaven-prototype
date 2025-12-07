class_name Weapon
extends Area2D

@export var shooting_point: Marker2D
const BULLET = preload("res://scenes/weapons/bullet.tscn")
var current_stats: PlayerStats
@onready var shoot_timer: Timer = $ShootTimer


func setup(ps: PlayerStats):
	current_stats = ps
	shoot_timer.wait_time = 1.0 / current_stats.attack_speed
	shoot_timer.start()

func _physics_process(_delta):
	lock_at_nearest()

func _on_shoot_timer_timeout():
	fire()

func lock_at_nearest():  ## Função que locka no inimigo mais proximo
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)

func fire():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	get_tree().current_scene.add_child(new_bullet)
