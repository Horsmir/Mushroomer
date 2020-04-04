extends "res://src/actors/Actor.gd"


func _ready():
    _velocity.x = speed
    

func _physics_process(delta):
    _velocity.y += gravity * delta
    if is_on_wall():
        _velocity.x *= -1
        $AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
    _velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
