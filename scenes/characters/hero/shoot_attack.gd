class_name ShootAttack
extends Node

@export var bullet_spawner: BulletSpawner = null
@export var timer: Timer = null


func _get_input_angle_to():
    """
        Returns the angle of the joystick direction
    """
    var direction = Vector2(
        Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), 
        Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
    )
    
    return direction.angle()


func _handle_shooting():
    if not timer.is_stopped():
        return
        
    var shooting_direction = Input.get_vector("shoot_left", "shoot_right", "shoot_up", "shoot_down")    
    if shooting_direction == Vector2.ZERO:
        return
    
    var angle = _get_input_angle_to()
    
    bullet_spawner.shoot(angle)
    timer.start()


func _process(_delta):
    _handle_shooting()
