extends Control 
class_name shop

@export var plus_button: PackedScene
@export var minus_button: PackedScene
@export var card_container: HBoxContainer
@onready var text: Label = $TextureRect/HBoxContainer2/Text

func _ready() -> void:
	for i in range(1):
		var plus_button_instance = plus_button.instantiate()
		var minus_button_instance = minus_button.instantiate()
		card_container.add_child(minus_button_instance)
		card_container.add_child(plus_button_instance)

func _process(delta: float) -> void:
	text.text = str(Global.bank_text)
