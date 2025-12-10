class_name Mage
extends Resource

var health: float = 65
var damage: float = 14.0
var attack_speed: float = 1.5
var move_speed: float = 320.0
var health_regen: int = 1


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
