extends Control

onready var tween = Tween.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(tween)
	tween.interpolate_property($PanelContainer/HBoxContainer/SongTitle, "self_modulate",
		Color(0,0,0,0), Color(1,1,1,1), 0.5,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	check_song()
func check_song():
	if Settingsoperator.beatmaps.size() > 0:
		var song = Settingsoperator.beatmaps[Settingsoperator.SongID]
		$PanelContainer/HBoxContainer/SongTitle.text = song.Artist + " - " + song.Title
	else:
		$PanelContainer/HBoxContainer/SongTitle.text = "No Songs"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_song()
