class_name HUDController
extends CanvasLayer

# se precisar de mais coisas no HUD, escrever aqui cada linha
# EXEMPLO: 
# @onready var active_items: ActiveItems = $ActiveItems (classe)
@onready var health_bar: HealthBar = $HealthBar

func setup(player: Player) -> void:
	health_bar.setup(player.base_stats.health)
	player.health_changed.connect(health_bar.on_health_changed)
