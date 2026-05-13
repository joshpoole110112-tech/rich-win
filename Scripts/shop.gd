extends Sprite2D

var collision: bool = false
var pressed: bool = false
@onready var interact_text: CanvasLayer = $"Interact text"

func _on_area_2d_body_entered(_body: Node2D) -> void:
	collision = true
	interact_text.visible = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	collision = false
	interact_text.visible = false

func _process(_delta: float) -> void:
	if collision:
		if pressed == false:
			if Input.is_action_just_pressed("Interact"):
				interact_text.visible = false
				Global.Ui_shop_show = true
				pressed = true
		else:
			if Input.is_action_just_pressed("Interact"):
				Global.Ui_shop_show = false
				pressed = false
	else:
		Global.Ui_shop_show = false
		pressed = false
