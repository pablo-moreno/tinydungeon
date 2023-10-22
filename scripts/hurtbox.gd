"""
A hurtbox is an area attached to the character or enemy that detects hitboxes
"""
class_name HurtBox
extends Area2D


@export var damage: int = 10


func _ready():
    self.connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: HitBox):
    if not hitbox:
        return
    
    var health: Health = owner.find_child("Health")
    
    if health == null:
        printerr("Health node not found")
        return

    health.take_damage(hitbox.damage)
