extends Node2D

# the variable below is a blueprint for all meteors, extracted from the meteor scene
var meteor_scene: PackedScene = load("res://meteor.tscn")
var laser_scene: PackedScene = load("res://laser.tscn")

var health := 4

func _ready():
	#set up health bars
	get_tree().call_group('ui','set_health', health)
	#stars
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for star in $Stars.get_children():
		#position
		var random_x = rng.randi_range(0, int(size.x))
		var random_y = rng.randi_range(0, int(size.y))
		star.position = Vector2(random_x, random_y)
		
		# size/scale
		var random_scale = rng.randf_range(1, 2)
		star.scale = Vector2(random_scale, random_scale)
		
		# speed
		star.speed_scale = rng.randf_range(0.6, 1.4)

func _on_meteor_timer_timeout() -> void:
	
#	now I'm going to call an instance of every meteor_scene and 
#	assign it to a variable called meteor
	var meteor = meteor_scene.instantiate()
	
	
#	And now I will attach this instansiated meteor 
#   to a new node that wil hold it for as long as the timer is triggered
	$Meteors.add_child(meteor)
	
	# connect to meteor signal
	meteor.connect('collision', _on_meteor_collision)

func _on_meteor_collision():
	health -= 1
	get_tree().call_group('ui','set_health', health)
	if health <= 0:
		$AudioStreamPlayer2D.play()
		get_tree().change_scene_to_file("res://game_over.tscn")
	

func _on_player_laser(pos):
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	print(pos)
