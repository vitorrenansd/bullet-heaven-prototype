class_name EnemyAI
extends Node

@onready var enemy: Enemy = get_parent()
@onready var player: Player = get_node("/root/Game/Player")

const ATTACK_RANGE: float = 50.0 # distancia em px


func _physics_process(_delta: float) -> void:
	chase_player()

func chase_player() -> void:
	var direction := (player.global_position - enemy.global_position).normalized()
	enemy.velocity = direction * enemy.base_stats.move_speed
	enemy.move_and_slide()
	
	# ataca quando esta dentro do range
	if enemy.global_position.distance_to(player.global_position) <= ATTACK_RANGE:
		enemy.attack(player)
