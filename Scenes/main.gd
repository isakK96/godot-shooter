extends Node

var mob_scene = preload("res://Scenes/Actors/mob.tscn")
@onready var player: CharacterBody2D = $Player
@onready var mob_spawn_area_shape: CollisionShape2D = $MobSpawnArea/CollisionShape2D

func _ready() -> void:
	pass
	

func _process(delta: float) -> void:
	pass


func _on_mob_spawn_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	mob.global_position = get_enemy_spawn_pos()
	mob.target = player
	call_deferred("add_child", mob)

func get_enemy_spawn_pos() -> Vector2:
	var rect = mob_spawn_area_shape.shape.get_rect()
	var x = randf_range(rect.position.x, rect.end.x)
	var y = randf_range(rect.position.y, rect.end.y)
	
	return Vector2(x, y)
