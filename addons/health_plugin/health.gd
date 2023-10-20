@tool
extends Node

const MAX_HEALTH = 100
@export var health = MAX_HEALTH


func take_damage(damage):
	health = max(health - damage, 0)


func heal(amount):
	health = min(health + amount, MAX_HEALTH)
