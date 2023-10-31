extends Node2D


func _on_health_damaged(_amount):
    Input.start_joy_vibration(0, 1, 1, 0.5)
