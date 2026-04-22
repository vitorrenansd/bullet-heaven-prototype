class_name UpgradeMenu
extends CanvasLayer

signal upgrade_chosen(modifier: StatsModifier)

@onready var buttons: Array[Button] = [
	$Panel/VBox/Button1,
	$Panel/VBox/Button2,
	$Panel/VBox/Button3,
]


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func show_upgrades(upgrades: Array[StatsModifier]) -> void:
	visible = true
	get_tree().paused = true

	for i in buttons.size():
		var upgrade := upgrades[i]
		buttons[i].text = upgrade.name + "\n" + upgrade.description
		if buttons[i].pressed.is_connected(_on_button_pressed):
			buttons[i].pressed.disconnect(_on_button_pressed)
		buttons[i].pressed.connect(_on_button_pressed.bind(upgrade))

func _on_button_pressed(modifier: StatsModifier) -> void:
	visible = false
	get_tree().paused = false
	upgrade_chosen.emit(modifier)
