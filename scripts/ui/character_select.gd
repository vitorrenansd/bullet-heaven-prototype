class_name CharacterSelect
extends Control

signal selection_confirmed

@export var available_classes: Array[BaseStats] = []
@export var available_weapons: Array[WeaponData] = []
@export var available_weapon_scenes: Array[PackedScene] = []

@onready var class_grid: GridContainer = $Panel/HBox/ClassSection/GridContainer
@onready var weapon_grid: GridContainer = $Panel/HBox/WeaponSection/GridContainer
@onready var confirm_button: Button = $Panel/ConfirmButton

var selected_class_index: int = 0
var selected_weapon_index: int = 0


func _ready() -> void:
	_populate_grid(class_grid, available_classes, _on_class_selected)
	_populate_grid(weapon_grid, available_weapons, _on_weapon_selected)
	_update_selection()
	confirm_button.pressed.connect(_on_confirm)

func _populate_grid(grid: GridContainer, items: Array, callback: Callable) -> void:
	for i in items.size():
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(80, 80)
		btn.text = items[i].display_name
		btn.pressed.connect(callback.bind(i))
		grid.add_child(btn)

func _on_class_selected(index: int) -> void:
	selected_class_index = index
	_update_selection()

func _on_weapon_selected(index: int) -> void:
	selected_weapon_index = index
	_update_selection()

func _update_selection() -> void:
	# destaca o botão selecionado em cada grid
	for i in class_grid.get_child_count():
		class_grid.get_child(i).modulate = Color.WHITE if i != selected_class_index else Color.YELLOW
	for i in weapon_grid.get_child_count():
		weapon_grid.get_child(i).modulate = Color.WHITE if i != selected_weapon_index else Color.YELLOW

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_confirm()

func _on_confirm() -> void:
	if available_classes.is_empty() or available_weapons.is_empty():
		push_error("CharacterSelect: nenhuma classe ou arma disponível")
		return
	
	GlobalRunConfig.selected_class = available_classes[selected_class_index]
	GlobalRunConfig.selected_weapon_data = available_weapons[selected_weapon_index]
	GlobalRunConfig.selected_weapon_scene = available_weapon_scenes[selected_weapon_index]
	get_tree().change_scene_to_file("res://levels/world01.tscn")
