class_name AttackState
extends EnemyState

signal attack

@export var cooldown_timer: Timer


func _enter_state():
    super._enter_state()
    
    if cooldown_timer.is_stopped():
        print('he attacks')
        attack.emit()
        cooldown_timer.start()
