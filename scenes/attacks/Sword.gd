extends Node2D

enum DIRECTION {
    UP,
    DOWN,
    LEFT,
    RIGHT,
}

var _previous_sword_rotation = 0
var _current_rotation_from_enum = DIRECTION.UP


@onready var _animation_player = $AnimationPlayer


func _rotate_sword(input_direction: Vector2):
    var _current_rotation = _previous_sword_rotation
    
    if input_direction.x < 0 and abs(input_direction.x) > abs(input_direction.y):
        _current_rotation = rad_to_deg(-90)
        _current_rotation_from_enum = DIRECTION.LEFT

    elif input_direction.x > 0 and abs(input_direction.x) > abs(input_direction.y):
        _current_rotation = rad_to_deg(90)
        _current_rotation_from_enum = DIRECTION.RIGHT
        
    elif input_direction.y < 0 and abs(input_direction.y) > abs(input_direction.x):
        _current_rotation = deg_to_rad(0)
        _current_rotation_from_enum = DIRECTION.UP
        
    elif input_direction.y > 0 and abs(input_direction.y) > abs(input_direction.x):
        _current_rotation = deg_to_rad(180)
        _current_rotation_from_enum = DIRECTION.DOWN
        
    if _current_rotation != _previous_sword_rotation:
        rotation_degrees = _current_rotation


func _process(_delta):
    var direction = Input.get_vector("left", "right", "up", "down")
    
    _rotate_sword(direction)
    
    if Input.is_action_just_pressed("attack"):
        if _current_rotation_from_enum == DIRECTION.UP:        
            _animation_player.play("slash_up")
        if _current_rotation_from_enum == DIRECTION.DOWN:        
            _animation_player.play("slash_down")
        if _current_rotation_from_enum == DIRECTION.LEFT:        
            _animation_player.play("slash_left")
        if _current_rotation_from_enum == DIRECTION.RIGHT:        
            _animation_player.play("slash_right")
