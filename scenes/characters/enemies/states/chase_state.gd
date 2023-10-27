class_name ChaseState
extends EnemyState

@export var ray_cast: RayCast2D

signal lost_player


func _ready() -> void:
    set_physics_process(false)




func _physics_process(_delta) -> void:
    if not ray_cast.is_colliding():
        lost_player.emit()
        return

    var player = _get_player()
    _move_to(player.global_position)
