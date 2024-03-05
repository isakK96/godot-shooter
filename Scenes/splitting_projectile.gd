extends Bullet

var bullet_scene = preload("res://Scenes/bullet.tscn")



func split_projectile() -> void:
	for i in range(3):
		var projectile = bullet_scene.instantiate()
		projectile.position = global_position
		
		add_child(projectile)
		
