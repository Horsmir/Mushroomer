extends KinematicBody2D


onready var anim = $AnimationPlayer


func _on_ScanBox_body_entered(body):
    if body.global_position.x > global_position.x:
        $AnimatedSprite.scale.x = -1
    else:
        $AnimatedSprite.scale.x = 1
        
    anim.play("walk")


func _on_HitBox_body_entered(body):
    if body.has_method("die"):
        anim.play("attack")
        yield(anim, "animation_finished")
        body.die()
        


func _on_ScanBox_body_exited(body):
    anim.play("walk_back")
