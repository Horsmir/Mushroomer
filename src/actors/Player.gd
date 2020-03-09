extends Actor


onready var state_machine = $AnimationTree.get("parameters/playback")
onready var gun_ray = $GunRay


func get_input():
    var dir = 0
    
    if Input.is_action_just_pressed("shoot"):
        if PlayerData.mush_inedible > 0:
            state_machine.travel("shoot")
            yield($AnimationPlayer, "animation_finished")
        return
    
    if Input.is_action_just_pressed("attack1"):
        attack1()
        yield($AnimationPlayer, "animation_finished")
        return
    
    if Input.is_action_pressed("move_right"):
        dir += 1
        $Sprite.scale.x = 0.25
        gun_ray.scale.x = 1
    if Input.is_action_pressed("move_left"):
        dir -= 1
        $Sprite.scale.x = -0.25
        gun_ray.scale.x = -1
    if dir != 0:
        _velocity.x = lerp(_velocity.x, dir * speed, acceleration)
        state_machine.travel("run")
    else:
        _velocity.x = lerp(_velocity.x, 0, friction)
        state_machine.travel("idle")
    if sign(dir) != sign($HitBox.position.x) and dir != 0:
        $HitBox.position.x *= -1
        

func _physics_process(delta):
    get_input()
    _velocity.y += gravity * delta
    _velocity = move_and_slide(_velocity, FLOOR_NORMAL)
    if Input.is_action_just_pressed("jump"):
        if is_on_floor():
            state_machine.travel("jump")
            _velocity.y = jump_speed


func die():
    state_machine.travel("die")
    set_physics_process(false)


func attack1():
    state_machine.travel("melee")


func shoot():
    PlayerData.mush_inedible -= 1
    if gun_ray.is_colliding():
        var enem = gun_ray.get_collider()
        if enem.has_method("sleeping"):
            enem.sleeping()


func _on_HitBox_area_entered(area):
    if area.is_in_group("hurtbox"):
        area.take()

func end_die():
    PlayerData.deaths += 1


func _on_VisibilityNotifier2D_screen_exited():
    die()
