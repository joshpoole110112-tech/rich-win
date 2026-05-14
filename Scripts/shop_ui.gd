extends CanvasLayer

@onready var shop_ui: CanvasLayer = $"."
@onready var attack_price: Label = $Control/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/attack_price
@onready var attack_multiplier: Label = $Control/TextureRect/MarginContainer/VBoxContainer/Attack_multiplier


func _process(_delta: float) -> void:
	if Global.Ui_shop_show:
		shop_ui.visible = true
	else:
		shop_ui.visible = false


func _on_attack_button_pressed() -> void:
	pass
