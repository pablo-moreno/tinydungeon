class_name WanderState
extends EnemyState

@export var ray_cast: RayCast2D


signal found_player

func _ready() -> void:
    set_physics_process(false)
    super._ready()

func _enter_state() -> void:
    print("Wandering")
    set_physics_process(true)

func _exit_state() -> void:
    set_physics_process(false)

func _get_wandering_points() -> Array[Node]:
    return get_tree().get_nodes_in_group("wandering_points")

func _physics_process(_delta) -> void:    
    if ray_cast.is_colliding():
        found_player.emit()
        return

    var actor = _get_actor()
