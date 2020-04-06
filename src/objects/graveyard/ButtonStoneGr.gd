extends StaticBody2D


signal button_activated


func _on_Trigger_body_entered(body):
    $AnimationPlayer.play("activate")
    $Trigger/CollisionShape2D.set_deferred("disabled", true)
    
    
func send_signal():
    emit_signal("button_activated")
