extends CharacterBody2D

@export var speed:= 500
var can_shoot: bool = true
signal laser(pos)



func _ready():
	position = Vector2(100, 200)


func _process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	
	# shoot input
	if Input.is_action_just_pressed("shoot") and can_shoot:
		laser.emit($LaserStartPos.global_position)
		can_shoot = false
		$LaserTimer.start()
		$LaserSound.play()


func _on_laser_timer_timeout():
	can_shoot = true
