class_name WanderingBody2D
extends CharacterBody2D

@export var movement_speed: float = 75.0

var _target_points: Array[Node] = []

@onready var _navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _waiting_timer: Timer = $WaitingTimer
@onready var _hurt_timer: Timer = $HurtTimer


func _ready():
    # Retrieve a list of the nodes grouped as wandering_points
    _target_points = get_tree().get_nodes_in_group("wandering_points")
    
    _hurt_timer.stop()
    _navigation_agent.path_desired_distance = 4.0
    _navigation_agent.target_desired_distance = 4.0
    
    # Make sure to not await during _ready.
    call_deferred("actor_setup")


func actor_setup():
    # Wait for the first physics frame so the NavigationServer can sync.
    await get_tree().physics_frame
    
    var target: Area2D = _target_points.pick_random()
    
    set_movement_target(target.global_position)


func set_movement_target(movement_target: Vector2):
    _navigation_agent.target_position = movement_target


func _physics_process(_delta):
    if _hurt_timer.is_stopped():
        _animated_sprite.stop()
    
    if _navigation_agent.is_navigation_finished():
        _waiting_timer.start()
        
        var target = _target_points.pick_random()
        set_movement_target(target.global_position)
        return
    
    if not _waiting_timer.is_stopped():
        return

    var current_agent_position: Vector2 = global_position
    var next_path_position: Vector2 = _navigation_agent.get_next_path_position()

    var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized()
    velocity = new_velocity * movement_speed

    move_and_slide()


func _on_health_death():
    queue_free()


func _on_health_damaged():
    _hurt_timer.start()
    _animated_sprite.play("hurt")


func _on_hurt_box_hit():
    global_position = _target_points.pick_random().global_position
