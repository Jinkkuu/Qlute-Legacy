extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var sizex = $".".rect_size.x
onready var sizey = $".".rect_size.y
onready var tween = get_node("Tween")
# Called when the node enters the scene tree for the first time.
func _ready():
	if text != "":
		$"Label".text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _hover():
	tween.interpolate_property($".", "rect_min_size",
		Vector2(sizex, sizey), Vector2(sizex+20, sizey), 0.2,
			Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()


func _unhover():
	tween.interpolate_property($".", "rect_min_size",
		Vector2(sizex+20, sizey), Vector2(sizex, sizey), 0.2,
			Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()


func _pressed():
	tween.interpolate_property($".", "rect_min_size",
		Vector2(sizex+20, sizey), Vector2(sizex, sizey), 0.2,
			Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()


func _unpressed():
	tween.interpolate_property($".", "rect_min_size",
		Vector2(sizex, sizey), Vector2(sizex+20, sizey), 0.2,
			Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()
