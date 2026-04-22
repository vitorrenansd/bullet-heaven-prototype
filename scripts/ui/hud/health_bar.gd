class_name HealthBar
extends ProgressBar

@onready var hp_label: Label = $HPLabel


func setup(max_health: float) -> void:
	max_value = max_health
	value = max_health
	hp_label.text = str(int(max_health)) + " / " + str(int(max_health))

func on_health_changed(current: float, maximum: float) -> void:
	max_value = maximum
	value = current
	hp_label.text = str(int(current)) + " / " + str(int(maximum))
