class_name Bullet
extends Area2D

@onready var _hitbox: HitBox = $HitBox

@export var hitbox_collision_mask: int = 1
@export var hitbox_collision_layer: int = 1
@export var damage: int = 10
@export var knockback: int = 5
@export var speed = 100


func _ready():
    _hitbox.collision_layer = hitbox_collision_layer
    _hitbox.collision_mask = hitbox_collision_mask
    _hitbox.damage = damage
    _hitbox.knockback = knockback

func _process(delta):
    position += transform.x * speed * delta


func _on_hit_box_area_entered(_area):
    pass
