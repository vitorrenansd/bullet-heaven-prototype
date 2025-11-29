class_name Enemy
extends CharacterBody2D

@export var base_stats: int # placeholder EnemyType
@export var current_stats: EnemyStats
var enemy_ai: EnemyAI


func _ready():
	current_stats = EnemyStats.new(self)
	enemy_ai = EnemyAI.new()
	current_stats.recalculate_stats()
