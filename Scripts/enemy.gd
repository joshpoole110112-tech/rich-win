extends CharacterBody2D

@export var player: CharacterBody2D
@export var SPEED: int = 50
@export var CHASE_SPEED: int = 110
@export var ACCELERATION: int = 300

@onready var sprite: Sprite2D = $Sprite2D
@onready var ray_cast: RayCast2D = $Sprite2D/RayCast2D
@onready var timer: Timer = $Timer
@onready var immuaity: Timer = $Immuaity
@onready var hp_bar: ProgressBar = $HpBar
@onready var player_att_cooldown: Timer = $Player_att_cooldown

var Hit: bool = false
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2
var right_bounds: Vector2
var left_bounds: Vector2
var HP: int = 100
var can_be_hit: bool = false

enum States{
	WANDER,
	CHASE
}
var current_state = States.WANDER

func _ready() -> void:
	left_bounds = self.position + Vector2(-125,0)
	right_bounds = self.position + Vector2(125,0)

func _physics_process(delta: float) -> void:
	hp_bar.value = HP
	player_att_cooldown.wait_time = Global.Player_Cooldown
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()
	if Hit:
		if immuaity.time_left <= 0:
			Global.Player_HP -= 20
			immuaity.start()
	if can_be_hit:
		if Input.is_action_just_pressed("Attack"):
			if player_att_cooldown.time_left <= 0:
				HP -= Global.Player_Damage
				player_att_cooldown.start()
	#die
	if HP == 0:
		queue_free()

func look_for_player():
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider == player:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	elif current_state == States.CHASE:
		stop_chase()

func chase_player():
	timer.stop()
	current_state = States.CHASE

func stop_chase():
	if timer.time_left <= 0:
		timer.start()

func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)
	
	move_and_slide()

func change_direction():
	if current_state == States.WANDER:
		if sprite.flip_h:
			if self.position.x <= right_bounds.x:
				direction = Vector2(1,0)
			else:
				sprite.flip_h = false
				ray_cast.target_position = Vector2(-125,0)
		else:
			if self.position.x >= left_bounds.x:
				direction = Vector2(-1,0)
			else:
				sprite.flip_h = true
				ray_cast.target_position = Vector2(125,0)
	else:
		direction = (player.position - self.position).normalized()
		direction = sign(direction)
		if direction.x == 1:
			sprite.flip_h = true
			ray_cast.target_position = Vector2(125,0)
		else:
			sprite.flip_h = false
			ray_cast.target_position = Vector2(-125,0)


func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_timer_timeout() -> void:
	current_state = States.WANDER

#do damage
func _on_enemy_attack_box_area_entered(_area: Area2D) -> void:
	Hit = true
func _on_enemy_attack_box_area_exited(_area: Area2D) -> void:
	Hit = false

#take damagea
func _on_enemy_hit_box_area_entered(_area: Area2D) -> void:
	can_be_hit = true

func _on_enemy_hit_box_area_exited(_area: Area2D) -> void:
	can_be_hit = false
