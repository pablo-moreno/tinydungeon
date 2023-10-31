class_name Enemy
extends CharacterBody2D

@export var target: Node2D = null
@export var movement_speed: float = 50

@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var wander_state: WanderState = $FiniteStateMachine/WanderState
@onready var chase_state: ChaseState = $FiniteStateMachine/ChaseState
@onready var idle_state: IdleState = $FiniteStateMachine/IdleState

@onready var ray_cast_2d = $RayCast2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_timer: Timer = $Timers/HurtTimer


func _setup_fsm():
    """
    FiniteStateMachine flow:
    Wander -> Idle -> Wander -> Chase -> Idle
    """
    fsm.state = wander_state
    wander_state.found_player.connect(fsm.change_state.bind(chase_state))
    wander_state.navigation_ended.connect(fsm.change_state.bind(idle_state))
    wander_state.is_attacked.connect(fsm.change_state.bind(chase_state))
    idle_state.end_idle.connect(fsm.change_state.bind(wander_state))
    chase_state.lost_player.connect(fsm.change_state.bind(idle_state))

func _ready():
    _setup_fsm()


func _physics_process(_delta):
    if hurt_timer.is_stopped():
        animated_sprite.stop()
    
    ray_cast_2d.look_at(target.global_position)


func _on_health_death():
    queue_free()


func _on_health_damaged(_amount: int):
    hurt_timer.start()
    animated_sprite.play("hurt")
