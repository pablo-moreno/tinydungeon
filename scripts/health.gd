"""
This class handles everything about health management.
"""
class_name Health
extends Node

# Properties variables
@export var health = 100
@export var current_max_health = 100
@export var invulnerability_timer: Timer = null

# Signals
signal death
signal change_health(new_health: int)
signal change_max_health(new_max_health: int)
signal damaged
signal healed

func _ready():
    if invulnerability_timer != null:
        invulnerability_timer.one_shot = true


func take_damage(amount: int) -> void:
    """
    Handles taking damage
    
    Emits:
        - change_health
        - damaged
        - death
    """
    if invulnerability_timer and not invulnerability_timer.is_stopped():
        return
        
    
    Input.vibrate_handheld(500)
    
    health = max(health - amount, 0)
    change_health.emit(health)
    damaged.emit()

    if health == 0:
        print("You died :(")
        death.emit()
    
    if invulnerability_timer:
        print("start invulnerability")
        invulnerability_timer.start()


func heal(amount: int) -> void:
    """
    Handles healing
    
    Emits: 
        - change_health
        - healed
    """
    health = min(health + amount, current_max_health)
    change_health.emit(health)
    healed.emit()


func increase_max_health(amount: int) -> void:
    """
    Handles maximum health increment
    
    Emits: 
        - change_max_health
    """
    current_max_health += amount
    change_max_health.emit(current_max_health)
