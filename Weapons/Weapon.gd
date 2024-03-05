extends Node2D
class_name Weapon

var damage := 10
var attack_cooldown := 1.0
var projectile_scene = preload("res://Scenes/bullet.tscn")
var on_cooldown := false
var projectile_position : Marker2D
var attack_range : Area2D
var attack_target : Mob = null
var audio_player : AudioStreamPlayer

func _ready() -> void:
	audio_player = $AudioStreamPlayer

func shoot(direction: Vector2) -> void:
	pass

func _physics_process(delta: float) -> void:
	attack_nearest_enemy()

func get_target() -> void:
	var enemies = attack_range.get_overlapping_bodies()
	var nearest_distance = 999999
	var nearest_enemy = null
	
	for enemy in enemies:
		if enemy is Mob:
			var distance = position.distance_squared_to(enemy.global_position)
			
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_enemy = enemy
			
	if nearest_enemy:
		attack_target = nearest_enemy
	else:
		attack_target = null
	
func get_attack_direction() -> Vector2:	
	return global_position.direction_to(attack_target.global_position)

func attack_nearest_enemy() -> void:
	get_target()
	if attack_target:
		look_at(attack_target.global_position)
		shoot(get_attack_direction())
