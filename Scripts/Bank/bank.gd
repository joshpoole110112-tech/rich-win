extends Sprite2D

@onready var interact_text: CanvasLayer = $"Interact text"

var is_near_bank: bool = false
var pressed: bool = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	is_near_bank = true
	interact_text.visible = true
func _on_area_2d_body_exited(_body: Node2D) -> void:
	is_near_bank = false
	interact_text.visible = false

func _process(_delta: float) -> void:
	if is_near_bank:
		if pressed == false:
			if Input.is_action_just_pressed("Interact"):
				interact_text.visible = false
				Global.Ui_bank_show = true
				pressed = true
		else:
			if Input.is_action_just_pressed("Interact"):
				Global.Ui_bank_show = false
				pressed = false
				Global.bank_text = 0
	else:
		Global.Ui_bank_show = false
		pressed = false
		Global.bank_text = 0
