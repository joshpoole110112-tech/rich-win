extends CharacterBody2D

@onready var interact_text: CanvasLayer = $"Interact text"

var in_collision: bool = false
func _process(_delta: float) -> void:
	if in_collision:
		if Input.is_action_just_pressed("Interact"):
			interact_text.visible = false
			if Global.Q_state == 1:
				DialogueManager.show_example_dialogue_balloon(load("uid://rub3eqesw0ni"), "Q1")
			elif Global.Q_state == 2:
				DialogueManager.show_example_dialogue_balloon(load("uid://rub3eqesw0ni"), "Q2")
			Global.player_freeze = true
	await DialogueManager.dialogue_ended
	Global.player_freeze = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	in_collision = true
	interact_text.visible = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	in_collision = false
	interact_text.visible = false
