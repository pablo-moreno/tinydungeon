class_name EnemyState
extends State

@export var navigation_agent: NavigationAgent2D
@export var waiting_timer: Timer


func _ready():
    navigation_agent.path_desired_distance = 4.0
    navigation_agent.target_desired_distance = 4.0
    
    call_deferred("actor_setup")


func actor_setup():
    # Wait for the first physics frame so the NavigationServer can sync.
    await get_tree().physics_frame


func set_movement_target(target_position: Vector2):
    navigation_agent.target_position = target_position


func _move_to(target_position: Vector2):
    navigation_agent.target_position = target_position
    
    if navigation_agent.is_navigation_finished():
        set_movement_target(target_position)
        return
    
    var actor: Enemy = _get_actor()
    
    var current_agent_position: Vector2 = actor.global_position
    var next_path_position: Vector2 = navigation_agent.get_next_path_position()
    
    var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized()
    actor.velocity = new_velocity * actor.movement_speed
    
    actor.move_and_slide()


func _get_player() -> Node:
    return get_tree().get_current_scene().find_child("Player")


func _get_actor() -> Node:
    return get_parent().get_parent()
