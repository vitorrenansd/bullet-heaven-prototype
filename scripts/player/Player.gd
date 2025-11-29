class_name Player
extends CharacterBody2D

@export var base_stats: Warrior # Atualmente fixo nos stats do Warrior
@export var modifiers: Array[StatsModifier] = [] # Lista de modificadores ativos (itens? livros?)
@export var current_stats: PlayerStats
@export var current_health: int
var movement: PlayerMovement

func _ready(): # Chama quando o obj fica prontos
	current_stats = PlayerStats.new(self)
	movement = PlayerMovement.new(self)
	current_stats.recalculate_stats()

func _physics_process(delta): # Faz handle da movimentacao 
	movement.tick(delta)

func add_modifier(modifier: StatsModifier) -> void: # Add modificador pra run do player (item? livro?)
	modifiers.append(modifier)
	current_stats.recalculate_stats()
