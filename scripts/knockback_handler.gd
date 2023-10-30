class_name KnockbackHandler
extends Node


func _on_hurt_box_knockback_received(direction, amount):
    print("knockback received", direction, amount)
    
    owner.global_position += -direction * amount
    owner.move_and_slide()
