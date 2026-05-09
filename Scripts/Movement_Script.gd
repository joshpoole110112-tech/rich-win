extends CharacterBody2D

@onready var coin_lable: Label = $Coin_count/Coin_Lable
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
@onready var att_time: Timer = $Att_time

var SPEED = 150.0
var JUMP_VELOCITY = -300.0
var current_animation = "Idle"
var is_attacking: bool = false
var mouse_poss = null

func _physics_process(delta: float) -> void:
	progress_bar.value = Global.Player_HP
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

func _process(_delta: float) -> void:
	if is_attacking:
		if att_time.time_left <= 0:
			att_time.start()
		mouse_poss = sign(get_local_mouse_position())
		if mouse_poss.x == 1:
			animated.play("Attack right")
		else:
			animated.play("Attack left")
	else:
		animated.play("Idle")

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("Attack"):
		is_attacking = true

func _on_collect_box_area_entered(_area: Area2D) -> void:
	Global.Coin += 10
	coin_lable.text = "Coins: " + str(Global.Coin)


func _on_att_time_timeout() -> void:
	is_attacking = false
