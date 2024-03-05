extends Weapon
class_name Bow

@onready var marker_2d: Marker2D = $Marker2D
var projectiles := 5

func _ready() -> void:
	#projectile_scene = preload("res://Scenes/splitting_projectile.tscn")
	damage = 20
	attack_cooldown = 1.0
	projectile_position = marker_2d
	attack_range = $AttackRange
	
	
func shoot(direction: Vector2) -> void:
	if !on_cooldown:
		fireMultipleProjectiles(projectiles, 1, direction.angle(), projectile_scene)
		
		on_cooldown = true
		await get_tree().create_timer(attack_cooldown).timeout
		on_cooldown = false

func _on_bullet_expire(bullet) -> void:
	for i in range(3):
		var newbullet = projectile_scene.instantiate()
		newbullet.position = bullet.global_position
		newbullet.direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		call_deferred("add_child", newbullet)


func fireMultipleProjectiles(numProjectiles: int, spreadAngle: float, initialAngle: float, projectileScene: PackedScene):
	var angleBetweenProjectiles = spreadAngle / (numProjectiles - 1)
	var currentAngle = initialAngle - (spreadAngle / 2)

	for i in range(numProjectiles):
		var direction = Vector2(cos(currentAngle), sin(currentAngle)).normalized()
		var projectile = projectileScene.instantiate()
		
		projectile.global_position = projectile_position.global_position
		projectile.direction = direction
		projectile.removed.connect(_on_bullet_expire)
		get_parent().add_child(projectile)

		currentAngle += angleBetweenProjectiles
