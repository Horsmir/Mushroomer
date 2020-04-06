extends KinematicBody2D


onready var anim = $AnimationPlayer


func _on_ScanBox_body_entered(body):
    if body.global_position.x > global_position.x:
        $AnimatedSprite.scale.x = -1
        $HitBox/CollisionShape2D.position.x = 71.0
        $AttackBox/CollisionShape2D.position.x = 52.0
    else:
        $AnimatedSprite.scale.x = 1
        $HitBox/CollisionShape2D.position.x = -71.0
        $AttackBox/CollisionShape2D.position.x = -52.0
        
    anim.play("walk")
        

func _on_ScanBox_body_exited(body):
    anim.play("walk_back")
    $AudioAttack.stop()


func _on_AttackBox_body_entered(body):
    anim.play("attack")


func _on_HitBox_body_entered(body):
    if body.has_method("die"):
        body.die()
