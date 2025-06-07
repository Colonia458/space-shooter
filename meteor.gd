extends Area2D

var meteor_graphic: Array = [
	load("res://Graphics/Meteors/meteorBrown_big1.png"),
	load("res://Graphics/Meteors/meteorBrown_big2.png"),
	load("res://Graphics/Meteors/meteorBrown_big3.png"),
	load("res://Graphics/Meteors/meteorBrown_big4.png"),
	load("res://Graphics/Meteors/meteorGrey_big1.png"),
	load("res://Graphics/Meteors/meteorGrey_big2.png"),
	load("res://Graphics/Meteors/meteorGrey_big3.png"),
	load("res://Graphics/Meteors/meteorGrey_big4.png")
]

var speed: int
var direction_x: float
var rotating_speed: int

signal collision

func _ready():
#	rng is just a variable that we will use to 
#	create a random number every single time
	var rng:= RandomNumberGenerator.new()
	
#	width is a variable that will 
#	get the current window width, 
#	catering for when it is maximized or resized
	var width = get_viewport().get_visible_rect().size[0]
	
#	random_x is a variable for placing a meteor 
#	at a random point on the x-axis, in respect to
#	the window width
	var random_x = rng.randi_range(0, width)
	
#	random_y is different. 
#	We don't need the window height
#	but we want the meteors to be seen as if 
#	they are falling from the sky(?)
	var random_y = rng.randi_range(-150, -50)
	
	
#	now, position takes the values of 
#	random_x and random-y
	position = Vector2(random_x,random_y)
	
	
#	speed/ rotation/ direction

	#I overwrote speed from the global variable
	speed = rng.randi_range(200,500)
	direction_x = rng.randf_range(-1, 1)
	rotating_speed = rng.randi_range(40,100)

#	Now here's the trickiest part.
#	The tutorial uses a string path method,
#	while i used a global array
#	The other tricky part? Loading a texture through a 
#	random range, which is the array's indices
#	Guess what? It worked still XD
	rng.randomize()
	var random_texture = meteor_graphic[rng.randi_range(0, meteor_graphic.size()-1)]
	$MeteorBP.texture = random_texture


func _process(delta):
#	the postion here changes to enable the meteors to
#	literally fall down
	position += Vector2(direction_x, 1.0) * speed * delta
	rotation_degrees += rotating_speed * delta
	
func _on_body_entered(_body):
	emit_signal('collision')
	call_deferred('queue_free')


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()
