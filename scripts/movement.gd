class_name MovingCharacterBody2D
extends CharacterBody2D

@export var SPEED = 150.0
@export var DASH_MODIFIER: float = 10

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _dash_timer: Timer = $DashTimer
@onready var _hurt_timer: Timer = $HurtTimer
@onready var _invulnerability_timer: Timer = $InvulnerabilityTimer


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
        
        velocity = input_direction * (SPEED * DASH_MODIFIER)

    # Regular movement
    else:
        velocity = input_direction * SPEED

    move_and_slide()

func _on_health_damaged():
    _hurt_timer.start()
