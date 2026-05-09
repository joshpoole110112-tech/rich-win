extends CharacterBody2D

@onready var coin_lable: Label = $Coin_count/Coin_Lable

const SPEED = 150.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	#gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#walk
	var direction := Input.get_axis("M_left", "M_Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_collect_box_area_entered(area: Area2D) -> void:
	Global.Coin += 1
	coin_lable.text = "Coins: " + str(Global.Coin)
