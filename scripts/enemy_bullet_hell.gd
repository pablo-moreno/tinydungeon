class_name EnemyBulletHellAttack
extends Node2D

@export var spawner: BulletSpawner = null
@export var bullet_timer: Timer = null
@export var enabled: bool = true
@export var cooldown: float = 0.25


enum ORIENTATION {
    UP,
    ROTATED,
}

var current_orientation = ORIENTATION.UP

func _ready():
    bullet_timer.wait_time = cooldown


func _physics_process(_delta):
    if not enabled:
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
