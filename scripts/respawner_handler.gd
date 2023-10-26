class_name RespawnerHandler
extends Node


@export var node_group_name_to_respawn: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func respawn():
    var _target_points = get_tree().get_nodes_in_group(node_group_name_to_respawn)
    var _random_point = _target_points.pick_random()
    owner.global_position = _random_point.global_position
