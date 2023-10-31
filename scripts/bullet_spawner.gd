class_name BulletSpawner
extends Node2D

@export var bullet_timer: Timer = null
@export var target_collision_mask = 4
@export var target_collision_layer = 4

@export var target: Node2D = null

enum ORIENTATION {
    UP,
    ROTATED,
}

var current_orientation = ORIENTATION.UP

func _ready():
    if target != null:
        var hurtbox: HurtBox = target.find_child("HurtBox")
        target_collision_layer = hurtbox.collision_mask
        target_collision_mask = hurtbox
    
    if bullet_timer != null:
        bullet_timer.one_shot = true
        bullet_timer.start()

func _process(_delta):
    if bullet_timer.is_stopped():
        if current_orientation == ORIENTATION.UP:
            shoot(deg_to_rad(0))
            shoot(deg_to_rad(90))
            shoot(deg_to_rad(180))
            shoot(deg_to_rad(270))
            current_orientation = ORIENTATION.ROTATED
        else:
            shoot(deg_to_rad(45))
            shoot(deg_to_rad(135))
            shoot(deg_to_rad(225))
            shoot(deg_to_rad(315))
            current_orientation = ORIENTATION.UP
            
        bullet_timer.start()

func shoot(radians: float):
    var bullet: Bullet = preload("res://scenes/attacks/Bullet.tscn").instantiate()
    bullet.hitbox_collision_mask = target_collision_layer
    bullet.hitbox_collision_layer = target_collision_mask
    print("spawning")
    bullet.rotate(radians)
    add_child(bullet)
