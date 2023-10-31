class_name EnemyAxisShootingAttack
extends Node2D

@export var spawner: BulletSpawner = null
@export var bullet_timer: Timer = null
@export var enabled: bool = true
@export var cooldown: float = 0.5
@export var wave_timer: Timer = null
@export var wait_timer: Timer = null

enum ORIENTATION {
    UP,
    ROTATED,
}

var current_orientation = ORIENTATION.UP
var is_shooting = true

func _ready():
    bullet_timer.wait_time = cooldown
    wave_timer.start()

func _handle_timers():
    # Si la oleada está parada y el temporizador de espera está parado
    if wave_timer.is_stopped() and is_shooting:
        wait_timer.start()
        is_shooting = false
    
    if wait_timer.is_stopped() and not is_shooting:
        wave_timer.start()
        is_shooting = true

func _physics_process(_delta):
    if not enabled:
        return
    
    _handle_timers()
    
    if not is_shooting:
        return

    if bullet_timer.is_stopped():
        if current_orientation == ORIENTATION.UP:
            spawner.shoot(deg_to_rad(0))
            spawner.shoot(deg_to_rad(90))
            spawner.shoot(deg_to_rad(180))
            spawner.shoot(deg_to_rad(270))
            current_orientation = ORIENTATION.ROTATED
        else:
            spawner.shoot(deg_to_rad(45))
            spawner.shoot(deg_to_rad(135))
            spawner.shoot(deg_to_rad(225))
            spawner.shoot(deg_to_rad(315))
            current_orientation = ORIENTATION.UP
            
        bullet_timer.start()
