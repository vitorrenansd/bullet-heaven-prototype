class_name Weapon
extends Area2D

@export var shooting_point: Marker2D
@export var data: WeaponData

var weapon_range: Area2D
var attack_speed: float
var damage: float

@onready var shoot_timer: Timer = $ShootTimer
@onready var sprite: Sprite2D = $WeaponPivot/Sprite2D


func _ready() -> void:
	if not data:
		push_error("Weapon: data não atribuído no inspector")
		return

func _physics_process(_delta: float) -> void:
	if shoot_timer.is_stopped():
		lock_n_load()


func setup(p_damage: float, p_attack_speed: float, p_weapon_range: Area2D) -> void:
	weapon_range = p_weapon_range
	damage = p_damage * data.damage_multiplier
	shoot_timer.wait_time = 1.0 / (data.attack_speed * p_attack_speed)
	shoot_timer.one_shot = true
	shoot_timer.autostart = false

func lock_n_load() -> void:
	var enemies_in_range := weapon_range.get_overlapping_bodies()
	if enemies_in_range.is_empty():
		return

	var nearest_enemy := _find_nearest(enemies_in_range)
	var target_angle := shooting_point.global_position.angle_to_point(nearest_enemy.global_position)
	
	## inverte o sprite caso esteja alem de 180 graus de giro
	sprite.flip_v = target_angle > PI / 2 or target_angle < -PI / 2
	
	## tween apenas visual pra ficar gostoso
	var tween := create_tween()
	tween.tween_property(self, "rotation", target_angle, shoot_timer.wait_time * 0.3)
	
	shoot_timer.start()
	## atira na hora com o angulo correto, sem esperar o tween acima
	## tentei esperar o tween mas o tiro ficou com atraso
	fire(target_angle)

func _find_nearest(enemies: Array) -> Enemy:
	var nearest: Enemy = enemies[0]
	var nearest_dist := global_position.distance_squared_to(nearest.global_position)
	for enemy in enemies:
		var dist := global_position.distance_squared_to(enemy.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = enemy
	return nearest

func fire(target_angle: float) -> void:
	# calcula o angulo inicial para centralizar o spread
	var start_angle := target_angle - deg_to_rad(data.spread_angle * (data.projectile_count - 1) / 2.0)
	for i in data.projectile_count:
		var new_bullet := data.bullet_scene.instantiate()
		new_bullet.global_position = shooting_point.global_position
		new_bullet.global_rotation = start_angle + deg_to_rad(data.spread_angle * i)
		new_bullet.damage = damage
		new_bullet.piercing = data.piercing
		get_tree().current_scene.add_child(new_bullet)
