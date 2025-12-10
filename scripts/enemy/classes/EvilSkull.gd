class_name EvilSkull
extends Resource

var health: float = 10
var damage: float = 10.0
var move_speed: float = 200


func get_health() -> float:
	return self.health

func get_damage() -> float:
	return self.damage

func get_move_speed() -> float:
	return self.move_speed
