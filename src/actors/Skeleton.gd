extends "res://src/actors/Actor.gd"


onready var anim = $AnimationPlayer

var dead = false
var scale_pos = 0.0
var hit_pos = 0.0
var attack_pos = 0.0
var col_pos = 0.0
var vel = 0.0


func _ready():
    _velocity.x = -speed
    anim.play("walk")


func _physics_process(delta):
    _velocity.y += gravity * delta
    if is_on_wall():
        _velocity.x *= -1
        scale.x *= -1
        $HitBox.position.x *= -1
        $AttackBox.position.x *= -1
        $CollisionShape2D.position.x *= -1
    _velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_AttackBox_body_entered(body):
    _velocity.x = 0
    yield(get_tree().create_timer(0.5), "timeout")
    if not dead:
        anim.play("attack")
        yield(anim, "animation_finished")
        anim.play("idle")


func _on_HitBox_body_entered(body):
    body.die()


func die():
    dead = true
    anim.stop()
    anim.play("die")
    $DieTimer.start()
    scale_pos = scale.x
    hit_pos = $HitBox.position.x
    attack_pos = $AttackBox.position.x
    col_pos = $CollisionShape2D.position.x
    vel = _velocity.x


func _on_DieTimer_timeout():
    dead = false
    anim.play("appear")
    yield(anim, "animation_finished")
    _velocity.x = vel
    scale.x = scale_pos
    $HitBox.position.x = hit_pos
    $AttackBox.position.x = attack_pos
    $CollisionShape2D.position.x = col_pos
    anim.play("walk")
    
