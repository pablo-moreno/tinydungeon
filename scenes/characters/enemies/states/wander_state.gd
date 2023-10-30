class_name WanderState
extends EnemyState

@export var ray_cast: RayCast2D

signal found_player

func _ready() -> void:
    set_physics_process(false)
    super._ready()


func _navigation_ended():
    var random_point = _get_wandering_points().pick_random().global_position
    set_movement_target(random_point)
    navigation_ended.emit()


func _get_wandering_points() -> Array[Node]:
    return get_tree().get_nodes_in_group("wandering_points")


func _physics_process(_delta) -> void:    
    if ray_cast.is_colliding():
        found_player.emit()
        return
    
    _move_to(Vector2.ZERO, 0.5)
