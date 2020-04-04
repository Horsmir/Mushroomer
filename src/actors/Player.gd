extends Actor


onready var gun_ray = $GunRay
onready var anim = $AnimationTree.get("parameters/playback")
onready var sprite = $AnimatedSprite

export var camera_limit_right = 20000

var dead = false


func _ready():
    $Camera2D.limit_right = camera_limit_right


func get_input():
    if dead:
        return
    var dir = 0
    
    if Input.is_action_just_pressed("shoot"):
        if PlayerData.mush_inedible > 0 and PlayerData.mush_edible > 0:
            anim.travel("shoot")
        return
    
    if Input.is_action_just_pressed("attack1"):
        attack1()
        return
    
    if Input.is_action_pressed("move_right"):
        dir += 1
        sprite.flip_h = false
        gun_ray.scale.x = 1
    elif Input.is_action_pressed("move_left"):
        dir -= 1
        sprite.flip_h = true
        gun_ray.scale.x = -1
    if dir != 0:
        _velocity.x = lerp(_velocity.x, dir * speed, acceleration)
        anim.travel("run")
        if sign(dir) != sign($HitBox.position.x):
            $HitBox.position.x *= -1
    else:
        _velocity.x = lerp(_velocity.x, 0, friction)
        anim.travel("idle")
        

func _physics_process(delta):
    get_input()
    _velocity.y += gravity * delta
    _velocity = move_and_slide(_velocity, FLOOR_NORMAL)
    if Input.is_action_just_pressed("jump"):
        if is_on_floor() and not dead:
            anim.travel("jump")
            _velocity.y = jump_speed


func die():
    dead = true
    anim.travel("dead")


func attack1():
    anim.travel("melee")
    


func shoot():
    PlayerData.mush_inedible -= 1
    PlayerData.mush_edible -= 1
    if gun_ray.is_colliding():
        var enem = gun_ray.get_collider()
        if enem.has_method("sleeping"):
            enem.sleeping()


func _on_HitBox_area_entered(area):
    if area.is_in_group("hurtbox"):
        area.take()

func end_die():
    PlayerData.deaths += 1
    set_physics_process(false)


func _on_VisibilityNotifier2D_screen_exited():
    die()


func _on_HitBox_body_entered(body):
    if body.has_method("die"):
        body.die()
