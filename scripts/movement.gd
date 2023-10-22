extends CharacterBody2D

@export var SPEED = 50.0
@export var DASH_MODIFIER: float = 1.5

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _timer: Timer = $Timer

func _physics_process(_delta):
    var input_direction = Input.get_vector("left", "right", "up", "down")
    var is_dash = Input.is_action_just_pressed("dash")
    
    if is_dash:
        print("dashinggggggg")
        print("timer stopped", _timer.is_stopped())
    
    if input_direction.x > 0 or input_direction.y > 0:
        _animated_sprite.play("default")
    
    if _timer.is_stopped() and is_dash:
        print("enters")
        _timer.start()
        velocity = input_direction * (SPEED * DASH_MODIFIER)
        print(velocity)
    else:
        velocity = input_direction * SPEED
    
    move_and_slide()

func _on_health_damaged():
    _animated_sprite.play("hurt")
