extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var fps = ResourceLoader.load("res://Panels/Overlay/FPSCounter.tscn")
	add_child(fps.instance())

