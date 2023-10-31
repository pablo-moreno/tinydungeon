class_name MovingCharacterBody2D
extends CharacterBody2D

@export var SPEED = 150.0
@export var DASH_MODIFIER: float = 10

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _dash_timer: Timer = $Timers/DashTimer
@onready var _hurt_timer: Timer = $Timers/HurtTimer
@onready var _invulnerability_timer: Timer = $Timers/InvulnerabilityTimer
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

enum ORIENTATION {
    UP,
    DOWN,
    LEFT,
    RIGHT
}

func _get_orientation_from_direction(input_direction: Vector2):
    if input_direction.x < 0 and abs(input_direction.x) > abs(input_direction.y):
        return ORIENTATION.LEFT

    elif input_direction.x > 0 and abs(input_direction.x) > abs(input_direction.y):
        return ORIENTATION.RIGHT
        
    elif input_direction.y < 0 and abs(input_direction.y) > abs(input_direction.x):
        return ORIENTATION.UP
        
    elif input_direction.y > 0 and abs(input_direction.y) > abs(input_direction.x):
        return ORIENTATION.DOWN

func _animate_dash(input_direction: Vector2):
    var orientation = _get_orientation_from_direction(input_direction)
    
    if orientation == ORIENTATION.UP:
        _animation_player.play("dash_up")
    if orientation == ORIENTATION.DOWN:
        _animation_player.play("dash_down")
    if orientation == ORIENTATION.LEFT:
        _animation_player.play("dash_left")
    if orientation == ORIENTATION.RIGHT:
        _animation_player.play("dash_right")


func _physics_process(_delta):
    var input_direction = Input.get_vector("left", "right", "up", "down")
    
    # Animation
    if not _hurt_timer.is_stopped():
        _animated_sprite.play("hurt")
    elif input_direction:
        _animated_sprite.play("default")
    else:
        _animated_sprite.play("idle")
    
    # Dash
    var is_dash = Input.is_action_just_pressed("dash")
    var _is_attack = Input.is_action_just_pressed("attack")
    
    if _dash_timer.is_stopped() and is_dash:
        _invulnerability_timer.start()
        _dash_timer.start()
        _animate_dash(input_direction)
        velocity = input_direction * (SPEED * DASH_MODIFIER)

    # Regular movement
    else:
        velocity = input_direction * SPEED
    
    move_and_slide()


func _on_health_damaged(_amount: int):
    _hurt_timer.start()


func _on_hurt_box_knockback_received(direction, amount):
    global_position += -direction * amount
    move_and_slide()
