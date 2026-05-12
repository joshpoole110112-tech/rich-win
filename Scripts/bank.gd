extends Sprite2D

var is_near_bank: bool = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	is_near_bank = true
func _on_area_2d_body_exited(_body: Node2D) -> void:
	is_near_bank = false

func _process(_delta: float) -> void:
	if is_near_bank:
		if Input.is_action_just_pressed("Interact"):
			pass
