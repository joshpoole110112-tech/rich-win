extends CanvasLayer

@onready var shop_ui: CanvasLayer = $"."
@onready var attack_price: Label = $Control/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/attack_price
@onready var attack_multiplier: Label = $Control/TextureRect/MarginContainer/VBoxContainer/Attack_multiplier
var attack_multiplier_var: float = 1.0
var attack_price_var: int = 50

func _process(_delta: float) -> void:
	if Global.Ui_shop_show:
		shop_ui.visible = true
	else:
		shop_ui.visible = false

func _on_attack_button_pressed() -> void:
	if Global.bank_money >= attack_price_var:
		Global.bank_money -= attack_price_var
		attack_multiplier_var += 0.1
		Global.Player_Damage *= attack_multiplier_var
		Global.Coin = Global.Player_Damage
		attack_multiplier.text = str(attack_multiplier_var) + "x"
