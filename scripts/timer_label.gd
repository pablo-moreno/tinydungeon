class_name TimerLabel
extends Label


@onready var _timer: Timer = $Timer


func _process(_delta):
    if _timer.is_stopped():
        visible = false


func _on_health_damaged(amount: int):
    _timer.start()
    visible = true
    text = str(-amount)
