class_name Hurtbox
extends Area2D

signal hurt(hitbox)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(hitbox: Area2D) -> void:
	if (not hitbox is Hitbox): return
	if owner.has_method("take_damage"):
		hurt.emit(hitbox)
		hitbox.hit_hurtbox.emit(self)
		owner.take_damage(hitbox.damage)
