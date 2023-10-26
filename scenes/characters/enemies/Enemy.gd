class_name Enemy
extends CharacterBody2D

@export var target: Node2D = null
@export var movement_speed: float = 50

@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var wander_state: WanderState = $FiniteStateMachine/WanderState
@onready var chase_state: ChaseState = $FiniteStateMachine/ChaseState
@onready var ray_cast_2d = $RayCast2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_timer: Timer = $HurtTimer


func _ready():
    wander_state.found_player.connect(fsm.change_state.bind(chase_state))
    chase_state.lost_player.connect(fsm.change_state.bind(wander_state))


func _physics_process(delta):
    if hurt_timer.is_stopped():
        animated_sprite.stop()
    
    var angle = ray_cast_2d.get_angle_to(target.global_position)
    ray_cast_2d.rotate(angle)
    ray_cast_2d.look_at(target.global_position)


func _on_health_death():
    queue_free()


func _on_health_damaged():
    hurt_timer.start()
    animated_sprite.play("hurt")
