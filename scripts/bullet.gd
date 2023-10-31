class_name Bullet
extends Area2D

@onready var _hitbox: HitBox = $HitBox
@onready var _timer: Timer = $LifeTimer
@onready var _sprite: Sprite2D = $Sprite2D

@export var hitbox_collision_mask: int = 1   ## Hitbox collision mask, set this as the collision layer of the target to be detected
@export var hitbox_collision_layer: int = 1  ## Hitbox collision layer, set this as the collision mask of the target to be detected

@export var damage: int = 10          ## HitBox damage
@export var knockback: int = 5        ## Knockback applied
@export var speed = 100               ## Bullet speed
@export var lifetime: float = 1.5     ## Bullet lifetime

@export var texture: CompressedTexture2D = null  ## Sprite texture


func _ready():
    if texture != null:
        _sprite.texture = texture
    
    _hitbox.collision_layer = hitbox_collision_layer
    _hitbox.collision_mask = hitbox_collision_mask
    _hitbox.damage = damage
    _hitbox.knockback = knockback
    _timer.one_shot = true
    _timer.wait_time = lifetime
    _timer.start()

func _process(delta): 
    position += transform.x * speed * delta
    
    if _timer.is_stopped():
        queue_free()

func _on_hit_box_area_entered(_area):
    pass

func _on_area_entered(_area):
    pass
