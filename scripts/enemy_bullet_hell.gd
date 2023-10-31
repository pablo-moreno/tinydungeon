class_name EnemyBulletHellAttack
extends Node2D

@export var spawner: BulletSpawner = null
@export var bullet_timer: Timer = null
@export var enabled: bool = true
@export var cooldown: float = 0.25
@export var rotate_speed: float = 100


enum ORIENTATION {
    UP,
    ROTATED,
}

var current_orientation = ORIENTATION.UP

func _ready():
    bullet_timer.wait_time = cooldown


func _physics_process(_delta):
    var new_rotation = spawner.rotation_degrees + rotate_speed * _delta
    spawner.rotation_degrees = fmod(new_rotation, 360)
    if not enabled:
        return

    if bullet_timer.is_stopped():
        spawner.shoot(deg_to_rad(spawner.rotation_degrees + 0))
        spawner.shoot(deg_to_rad(spawner.rotation_degrees + 90))
        spawner.shoot(deg_to_rad(spawner.rotation_degrees + 180))
        spawner.shoot(deg_to_rad(spawner.rotation_degrees + 270))
            
        bullet_timer.start()
