extends Weapon
class_name Pistol

@onready var marker_2d: Marker2D = $Marker2D

func _ready() -> void:
	attack_range = $AttackRange
	audio_player = $AudioStreamPlayer
	attack_cooldown = 0.5
	damage = 20
	projectile_position = marker_2d

func shoot(direction: Vector2):
	if !on_cooldown:
		audio_player.play()
		var bullet := projectile_scene.instantiate()
		bullet.position = projectile_position.global_position
		bullet.direction = direction
			
		add_child(bullet)
		
		on_cooldown = true
		await get_tree().create_timer(attack_cooldown).timeout
		on_cooldown = false
