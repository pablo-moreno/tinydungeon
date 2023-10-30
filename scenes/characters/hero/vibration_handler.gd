extends Node2D


func _on_health_damaged():
    Input.vibrate_handheld(500)
