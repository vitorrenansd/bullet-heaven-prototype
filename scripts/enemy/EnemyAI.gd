class_name EnemyAI
extends Node

var enemy: Enemy
@onready var player: Player = get_node("/root/GamePrototype/Player")


func _ready():
	enemy = get_parent() # o pai é Enemy

func _physics_process(_delta):
	chase_player()

func chase_player() -> void: # Persegue o jogador
	var enemy_ms = self.enemy.current_stats.move_speed
	var direction = (self.player.global_position - self.enemy.global_position).normalized()
	self.enemy.velocity = direction * enemy_ms
	self.enemy.move_and_slide()
