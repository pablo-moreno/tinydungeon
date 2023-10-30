extends RayCast2D


@onready var line = $Line2D
@export var is_casting: bool = false


func _physics_process(delta):
    force_raycast_update()
    
    if is_colliding():
        var cast_point = to_local(get_collision_point())
        line.points[1] = cast_point
