extends CharacterBody2D

@onready var health_bar: HealthBar = $HealthBar
@onready var pistol: Pistol = $Pistol as Pistol
@onready var bow: Bow = $Bow as Bow
@onready var weapon_position1: Marker2D = $WeaponPositions/Weapon1Position
@onready var weapon_position2: Marker2D = $WeaponPositions/Weapon2Position
@onready var weapon_position3: Marker2D = $WeaponPositions/Weapon3Position

var speed = 600
var acceleration = 5000
var friction = 3000
var health = 100
var screen_size
var equipped_weapons : Array = []
var current_weapon : Weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.player = self
	current_weapon = bow
	bow.global_position = weapon_position1.global_position
	pistol.global_position = weapon_position2.global_position
	equipped_weapons.append(bow)
	equipped_weapons.append(pistol)
	health_bar.init_health(health)
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#attack_target = get_target()
	#if attack_target:
		#look_at(attack_target.global_position)
		#for weapon in equipped_weapons:
			#weapon.shoot(get_attack_direction(attack_target))
		##current_weapon.shoot(get_attack_direction(attack_target))
	#else:
		#look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("shoot"):
		current_weapon.shoot(global_position.direction_to(get_global_mouse_position()))
	
	var move_input = Input.get_vector("left", "right", "up", "down")
	handle_movement(move_input, delta)
	
	if velocity != Vector2.ZERO:
		$AnimationPlayer.play("player_run")
	else:
		$AnimationPlayer.stop()
	
	move_and_slide()

	#position = position.clamp(Vector2.ZERO, screen_size)
	
func handle_movement(vector, delta):
	if vector: velocity = velocity.move_toward(vector * speed, delta * acceleration)
	else: velocity = velocity.move_toward(Vector2.ZERO, delta * friction)


func take_damage(damage: int) -> void:
	health -= damage
	health_bar.health = health
	if health <= 0:
		die()
		
func die() -> void:
	hide()
