extends CanvasLayer

@onready var shop_ui: CanvasLayer = $"."
@onready var attack_price: Label = $Control/TextureRect/MarginContainer/VBoxContainer/HBoxContainer/attack_price
@onready var attack_multiplier: Label = $Control/TextureRect/MarginContainer/VBoxContainer/Attack_multiplier
var attack_multiplier_var: float = 1.0
var attack_price_var: int = 50
var old_player_damage: float = Global.Player_Damage
var player_damage_diff: float
var old_player_damage_diff: float

func _process(_delta: float) -> void:
	if Global.Ui_shop_show:
		shop_ui.visible = true
	else:
		shop_ui.visible = false
	if old_player_damage != Global.Player_Damage:
		player_damage_diff = Global.Player_Damage - old_player_damage
		old_player_damage_diff = player_damage_diff
		player_damage_diff *= attack_multiplier_var
		if old_player_damage_diff != player_damage_diff:
			if not player_damage_diff < 0:
				Global.Player_Damage += player_damage_diff
				old_player_damage = Global.Player_Damage
				Global.Coin = Global.Player_Damage


func _on_attack_button_pressed() -> void:
	if Global.bank_money >= attack_price_var:
		Global.bank_money -= attack_price_var
		attack_multiplier_var += 0.1
		Global.Player_Damage *= attack_multiplier_var
		old_player_damage = Global.Player_Damage
		Global.Coin = Global.Player_Damage
		attack_multiplier.text = str(attack_multiplier_var) + "x"
