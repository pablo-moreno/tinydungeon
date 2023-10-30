"""
A hurtbox is an area attached to the character or enemy that detects hitboxes
"""
class_name HurtBox
extends Area2D

signal hit
signal knockback_received(direction: Vector2, amount: float)


func _ready():
    self.connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: HitBox):
    # Check if the hitbox is a sibling
    var is_sibling: bool = hitbox.get_parent() == get_parent()
    hit.emit()

    if not hitbox or is_sibling:
        # Do nothing
        return

    var health: Health = owner.find_child("Health")
    
    var knockback_direction = self.global_position.direction_to(hitbox.global_position)
    knockback_received.emit(knockback_direction, hitbox.knockback)

    if health == null:
        printerr("Health node not found")
        return

    health.take_damage(hitbox.damage)
