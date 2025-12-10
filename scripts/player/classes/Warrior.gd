class_name Warrior
extends Resource

var health: float = 100
var damage: float = 10.0
var attack_speed: float = 1.0
var move_speed: float = 250.0
var health_regen: int = 2


func get_health() -> float:
	return self.health

func get_damage() -> float:
	return self.damage

func get_attack_speed() -> float:
	return self.attack_speed

func get_move_speed() -> float:
	return self.move_speed

func get_health_regen() -> int:
	return self.health_regen
