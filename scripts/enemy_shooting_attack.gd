class_name EnemyShootingAttack
extends Node

@export var spawner: BulletSpawner = null
@export var bullet_timer: Timer = null

enum ORIENTATION {
    UP,
    ROTATED,
}

var current_orientation = ORIENTATION.UP


func _process(_delta):
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
