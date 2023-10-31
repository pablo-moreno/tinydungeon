class_name ShootAttack
extends Node

@export var bullet_spawner: BulletSpawner = null
@export var timer: Timer = null


func _handle_shooting():
    if not timer.is_stopped():
        return
        
    var shooting_direction = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down")    
    if shooting_direction == Vector2.ZERO:
        return
    
    var angle = get_parent().global_position.normalized().angle_to(shooting_direction)
    bullet_spawner.shoot(angle)
    timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    _handle_shooting()
