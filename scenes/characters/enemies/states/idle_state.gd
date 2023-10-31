class_name IdleState
extends EnemyState

signal end_idle

@export var idle_timer: Timer


var is_idle = false

func _ready():
    idle_timer.one_shot = true
    super._ready()


func _enter_state():
    super._enter_state()
    
    if idle_timer.is_stopped():
        is_idle = true
        idle_timer.start()

    
func _physics_process(_delta):
    if idle_timer.is_stopped() and is_idle:
        is_idle = false
        end_idle.emit()
