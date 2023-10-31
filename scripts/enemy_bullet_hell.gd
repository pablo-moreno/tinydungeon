class_name EnemyBulletHellAttack
extends Node2D

@export var spawner: BulletSpawner = null
@export var bullet_timer: Timer = null
@export var enabled: bool = true
@export var cooldown: float = 0.25
@export var rotate_speed: float = 100
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

func handle_timers():
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
    
    handle_timers()
    
    if not is_shooting:
        return
    
    var new_rotation = spawner.rotation_degrees + rotate_speed * _delta
    spawner.rotation_degrees = fmod(new_rotation, 360)

    if bullet_timer.is_stopped():
        spawner.shoot(deg_to_rad(spawner.rotation_degrees + 0))
        spawner.shoot(deg_to_rad(spawner.rotation_degrees + 90))
        spawner.shoot(deg_to_rad(spawner.rotation_degrees + 180))
        spawner.shoot(deg_to_rad(spawner.rotation_degrees + 270))
            
        bullet_timer.start()
