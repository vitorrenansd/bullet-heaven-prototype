class_name Enemy
extends CharacterBody2D

@export var base_stats: Resource # Recebe uma classe de inimigo (evil skull, ...)
@export var current_stats: EnemyStats
@export var current_health: int
var enemy_ai: EnemyAI


func _ready():
	current_stats = EnemyStats.new(self)
	enemy_ai = EnemyAI.new(self)
	current_stats.recalculate_stats()
