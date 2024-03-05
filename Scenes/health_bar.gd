extends ProgressBar
class_name HealthBar

@onready var damage_bar: ProgressBar = $DamageBar
@onready var timer: Timer = $Timer

var health = 0 : set = _set_health

func init_health(_health) -> void:
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health


func _set_health(new_health: int):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		hide()
		
	if health < prev_health:
		timer.start()
	else: damage_bar.value = health


func _on_timer_timeout() -> void:
	damage_bar.value = health
