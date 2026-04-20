class_name XPBar
extends ProgressBar

@onready var level_label: Label = $LevelLabel


func _ready() -> void:
	min_value = 0
	max_value = 100  # valor base, atualiza no primeiro xp_changed

func on_xp_changed(current_xp: int, xp_to_next_level: int) -> void:
	max_value = xp_to_next_level
	value = current_xp

func on_level_up(new_level: int) -> void:
	level_label.text = "Lv. " + str(new_level)
