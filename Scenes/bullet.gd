extends Node2D
class_name Bullet

var speed := 500.0
var damage := 200.0
var lifetime := 1.0
var direction := Vector2.ZERO

@export var impact_particle: PackedScene
@onready var hitbox: Hitbox = $hitbox
@onready var collision_shape: CollisionShape2D = $hitbox/CollisionShape2D
@onready var timer: Timer = $Timer
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

signal removed(bullet)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.damage = damage
	set_as_top_level(true)
	timer.start(lifetime)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_timer_timeout() -> void:
	removed.emit(self)
	queue_free()

func play_particle(particle_scene: PackedScene) -> void:
	var particle = particle_scene.instantiate()
	particle.position = global_position
	particle.emitting = true
	get_tree().current_scene.add_child(particle)
	
func _on_hitbox_hit_hurtbox(hurtbox: Variant) -> void:
	queue_free_after_audio()

func queue_free_after_audio():
	# Hide object and disable hitbox
	collision_shape.set_deferred("disabled", true)
	hide()
	
	removed.emit(self)
	
	play_particle(impact_particle)
	
	audio_player.play()
	await(audio_player.finished)
	queue_free()
