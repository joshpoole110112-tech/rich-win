extends Control 
class_name shop

@export var plus_button: PackedScene
@export var minus_button: PackedScene
@export var card_container: HBoxContainer
@onready var text: Label = $TextureRect/HBoxContainer2/Text
@onready var bank_ui: CanvasLayer = $".."
@onready var label_2: Label = $TextureRect/Label2

func _ready() -> void:
	
		var plus_button_instance = plus_button.instantiate()
		var minus_button_instance = minus_button.instantiate()
		card_container.add_child(minus_button_instance)
		card_container.add_child(plus_button_instance)

func _process(_delta: float) -> void:
	text.text = str(Global.bank_text)
	if Global.You_brock != true:
		label_2.text = str(Global.bank_money)
	if Global.Ui_bank_show:
		bank_ui.visible = true
	else:
		bank_ui.visible = false


func _on_submit_b_pressed() -> void:
	if Global.Coin - Global.bank_text < 0:
		Global.You_brock = true
		label_2.text = "You don't have enough coins!"
	else:
		Global.bank_money += Global.bank_text
		Global.Coin -= Global.bank_text
		Global.bank_text = 0
