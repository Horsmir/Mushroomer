extends Actor


onready var anim = $AnimationPlayer
var sleep_x = 0


func _ready():
    _velocity.x = speed
    anim.play("walk")


func _physics_process(delta):
    _velocity.y += gravity * delta
    if is_on_wall():
        _velocity.x *= -1
        scale.x *= -1
        $HitBox.position.x *= -1
    _velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_HitBox_body_entered(body):
    if body.has_method("die"):
        _velocity.x = 0
        anim.play("attack")
        yield(anim, "animation_finished")
        anim.play("idle")
        body.die()


func sleeping():
    sleep_x = _velocity.x
    _velocity.x = 0
    anim.play("sleep")
    $TimerSleep.start()


func _on_TimerSleep_timeout():
    _velocity.x = sleep_x
    set_collision_layer_bit(1, true)
    set_collision_layer_bit(4, false)
    set_collision_mask_bit(0, true)
    $HitBox/CollisionShape2D.set_deferred("disabled", false)
    anim.play("walk")
