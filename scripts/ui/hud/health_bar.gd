class_name HealthBar
extends ProgressBar

func setup(max_health: float) -> void:
	max_value = max_health
	value = max_health

func on_health_changed(current: float, _maximum: float) -> void:
	value = current
