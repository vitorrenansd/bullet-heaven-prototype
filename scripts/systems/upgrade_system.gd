class_name UpgradeSystem
extends Node

signal upgrades_rolled(upgrades: Array[StatsModifier])

@export var available_upgrades: Array[StatsModifier] = []

const CHOICES: int = 3


func roll() -> void:
	if available_upgrades.size() < CHOICES:
		push_error("UpgradeSystem: upgrades disponíveis insuficientes")
		return

	var pool := available_upgrades.duplicate()
	pool.shuffle()
	var rolled: Array[StatsModifier] = []

	for i in CHOICES:
		rolled.append(pool[i])

	upgrades_rolled.emit(rolled)
