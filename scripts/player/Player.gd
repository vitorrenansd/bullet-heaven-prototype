class_name Player
extends CharacterBody2D

signal health_depleted

@export var base_stats: Resource # Recebe uma classe de player (warrior, mago, ...)
var modifiers: Array[StatsModifier] = [] # Lista de modificadores ativos (itens)
@export var current_stats: PlayerStats
@onready var movement = $PlayerMovement


func _ready(): # Chama quando o obj fica pronto
	self.current_stats = PlayerStats.new(self)
	self.current_stats.recalculate_stats()
	
	var weapon = get_node("Pistol")
	weapon.setup(current_stats)

func _physics_process(delta): # Usa a movimentação da classe PlayerMovement
	self.movement.tick(delta)

func add_modifier(modifier: StatsModifier) -> void: # Add item na run atual do player
	self.modifiers.append(modifier)
	self.current_stats.recalculate_stats()

func take_damage(amount: float) -> void:
	var hp = self.current_stats.get_current_health()
	hp = ceil(hp - amount) # Arredonda pra cima
	self.current_stats.set_current_health(hp)
	if hp <= 0.0:
		health_depleted.emit()
