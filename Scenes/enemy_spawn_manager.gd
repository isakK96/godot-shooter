extends Node2D

@onready var mob_spawn_area: Area2D = $MobSpawnArea
@onready var timer: Timer = $Timer
var mob_scene = preload("res://Scenes/Actors/mob.tscn")

var mob_spawn_area_size: Vector2
var spawn_interval = 2

func _ready() -> void:
	mob_spawn_area_size = mob_spawn_area.get_node("CollisionShape2D").shape.get_rect().size
