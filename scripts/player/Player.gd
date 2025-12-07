class_name Player
extends CharacterBody2D

signal health_depleted

@export var base_stats: Resource # Recebe uma classe de player (warrior, mago, ...)
@export var modifiers: Array[StatsModifier] = [] # Lista de modificadores ativos (itens)
@export var current_stats: PlayerStats
var movement: PlayerMovement


func _ready(): # Chama quando o obj fica prontos
	current_stats = PlayerStats.new(self)
	movement = PlayerMovement.new(self)
	current_stats.recalculate_stats()
	
	var weapon = get_node("Pistol")
	weapon.setup(current_stats)

func _physics_process(delta): # Usa a movimentação da classe PlayerMovement
	movement.tick(delta)

func add_modifier(modifier: StatsModifier) -> void: # Add item na run atual do player
	modifiers.append(modifier)
	current_stats.recalculate_stats()

func take_damage(amount: float):
	current_stats.current_health -= amount
	current_stats.current_health = ceil(current_stats.current_health) # Arredonda pra cima
	if current_stats.current_health <= 0.0:
		health_depleted.emit()
