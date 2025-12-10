class_name Enemy
extends CharacterBody2D

@export var base_stats: Resource # Recebe um tipo de inimigo (evil skull, ...)
@export var current_stats: EnemyStats
var can_attack: bool = true


func _ready():
	self.current_stats = EnemyStats.new(self)
	self.current_stats.recalculate_stats()

func attack(player: Player) -> void:
	if not self.can_attack:
		return
	
	self.can_attack = false
	player.take_damage(current_stats.get_damage())
	await get_tree().create_timer(self.current_stats.get_attack_speed()).timeout
	self.can_attack = true

func take_damage(amount: float) -> void:
	var hp = self.current_stats.get_current_health()
	hp = ceil(hp - amount) # Arredonda pra cima
	self.current_stats.set_current_health(hp)
	if hp <= 0.0:
		queue_free() # morre/exclui
