class_name CameraLimitter
extends Node


func _ready():
    var _camera: Camera2D = owner.find_child("Camera2D")
    var _tilemap = get_tree().get_current_scene().get_node("TileMap")
    
    if not _tilemap or not _camera:
        printerr("Not tilemap or camera were found")
        return

    var rect = _tilemap.get_used_rect()
    var tile_size = _tilemap.tile_set.tile_size
    
    var limit_right = rect.size.x * tile_size.x
    var limit_bottom = rect.size.y * tile_size.y
    
    _camera.limit_bottom = limit_bottom
    _camera.limit_right = limit_right
