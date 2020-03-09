extends Actor


onready var anim = $AnimationPlayer


func _ready():
    _velocity.x = -speed
    $Sprite.scale.x = -1
    anim.play("run")


func _physics_process(delta):
    _velocity.y += gravity * delta
    if is_on_wall():
        _velocity.x *= -1
        $Sprite.scale.x *= -1
    _velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
