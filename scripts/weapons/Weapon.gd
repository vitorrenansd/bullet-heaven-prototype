class_name Weapon
extends Area2D

@export var shooting_point: Marker2D
@export var data: WeaponData

var weapon_range: Area2D
var attack_speed: float
var damage: float

@onready var shoot_timer: Timer = $ShootTimer


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

	var nearest_enemy := enemies_in_range[0]
	var nearest_dist := global_position.distance_squared_to(nearest_enemy.global_position)

	for enemy in enemies_in_range:
		var dist := global_position.distance_squared_to(enemy.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest_enemy = enemy

	look_at(nearest_enemy.global_position)
	## inverte o sprite caso esteja alem de 180 graus
	var sprite: Sprite2D = $WeaponPivot/Sprite2D
	sprite.flip_v = global_rotation > PI / 2 or global_rotation < -PI / 2
	
	fire()


func fire() -> void:
	# calcula o angulo inicial para centralizar o spread
	var start_angle := global_rotation - deg_to_rad(data.spread_angle * (data.projectile_count - 1) / 2.0)

	for i in data.projectile_count:
		var new_bullet := data.bullet_scene.instantiate()
		new_bullet.global_position = shooting_point.global_position
		new_bullet.global_rotation = start_angle + deg_to_rad(data.spread_angle * i)
		new_bullet.damage = damage
		new_bullet.piercing = data.piercing
		get_tree().current_scene.add_child(new_bullet)

	shoot_timer.start()
