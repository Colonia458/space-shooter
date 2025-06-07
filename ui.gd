extends CanvasLayer

static var image = load('res://Graphics/UI/playerLife3_green.png')
var time_elapsed := 0

func set_health(amount):
	#	remove all children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
		
	# create new children based on health
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP


func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	print(time_elapsed)
	$MarginContainer/Label.text = str(time_elapsed)
	Global.score = time_elapsed
