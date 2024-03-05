class_name Mob
extends CharacterBody2D

@onready var hitbox: Hitbox = $Hitbox
@onready var health_bar: ProgressBar = $HealthBar
@onready var hitflash_animation_player: AnimationPlayer = $HitflashAnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D


var speed := 300
var health := 5000
var damage := 20
var target: CharacterBody2D = null
var current_velocity := Vector2.ZERO
var acceleration := 1000.0
var direction := Vector2.ZERO

func _ready() -> void:
	health_bar.init_health(health)
	hitbox.damage = damage
	sprite_2d.material.set_shader_parameter("enabled", false)

func _physics_process(delta: float) -> void:	
	if target:
		direction = global_position.direction_to(target.global_position)
		velocity = velocity.move_toward(direction * speed, delta * acceleration)
		move_and_slide()
		look_at(target.global_position)
	else:
		direction = Vector2.ZERO


func take_damage(damage: int) -> void:
	health -= damage
	health_bar.health = health
	hitflash_animation_player.play("hitflash")
	if health <= 0:
		die()

func die() -> void:
	queue_free()
