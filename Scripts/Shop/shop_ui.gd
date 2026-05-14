extends CanvasLayer

@onready var player_money: Label = $"Control/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/Player money"
@onready var shop_ui: CanvasLayer = $"."
@onready var attack_price: Label = $Control/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/attack_price
@onready var attack_multiplier: Label = $Control/TextureRect/MarginContainer/VBoxContainer/Attack_multiplier
var var_attack_price: int = 50
var var_attack_multiplier: float = 1.0
var attack_damage: float = 0

func _process(_delta: float) -> void:
	player_money.text = str(Global.bank_money)
	if Global.Ui_shop_show:
		shop_ui.visible = true
	else:
		shop_ui.visible = false
	Global.Player_Damage = Global.Coin * var_attack_multiplier
	


func _on_attack_button_pressed() -> void:
	if Global.bank_money >= var_attack_price:
		Global.bank_money -= var_attack_price
		var_attack_multiplier += 0.1
		attack_multiplier.text = str(var_attack_multiplier) + "x"
