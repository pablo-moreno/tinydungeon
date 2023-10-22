extends CharacterBody2D

@export var SPEED = 50.0

@onready var _animated_sprite = $AnimatedSprite2D


func _physics_process(_delta):
    var input_direction = Input.get_vector("left", "right", "up", "down")
    
    if input_direction.x > 0 or input_direction.y > 0:
        _animated_sprite.play("default")

    velocity = input_direction * SPEED
    move_and_slide()
