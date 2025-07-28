extends Reference
class_name BeatmapLegend

var ID: int = 0
var SetID: int = 0
var Title: String = ""
var Artist: String = ""
var Mapper: String = ""
var KeyCount: int = 4
var Version: String = ""
var pp: float = 0.0
var Osubeatid: int = -1
var Osubeatidset: int = -1
var Beatid: int = -1
var Beatidset: int = -1
var Bpm: float = 0.0
var Dance: Array = [] # Replace with Array of DanceCounter
var Timetotal: int = 0
var Levelrating: float = 0.0
var Accuracy: float = 0.0
var Background: String = ""
var Audio: String = ""
var Rawurl: String = ""
var Path: String = ""

func _init():
	Dance = []
