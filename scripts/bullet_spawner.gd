class_name BulletSpawner
extends Node2D

@export var target_collision_mask = 4
@export var target_collision_layer = 4
@export var target: Node2D = null
@export var shoot_speed: float = 100
@export var bullet_texture: CompressedTexture2D = null


func _ready():
    if target != null:
        var hurtbox: HurtBox = target.find_child("HurtBox")
        target_collision_layer = hurtbox.collision_mask
        target_collision_mask = hurtbox


func shoot(radians: float):
    var bullet: Bullet = preload("res://scenes/attacks/Bullet.tscn").instantiate()
    bullet.hitbox_collision_mask = target_collision_layer
    bullet.hitbox_collision_layer = target_collision_mask
    bullet.speed = shoot_speed
    
    if bullet_texture != null:
        bullet.texture = bullet_texture
        
    bullet.rotate(radians)
    bullet.global_position.x = global_position.x
    bullet.global_position.y = global_position.y
    
    var scene = get_tree().get_current_scene()
    scene.add_child(bullet)
