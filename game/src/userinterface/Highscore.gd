extends Control

onready var highscore_names = [
	$BlackOverlay/Background/Scorelist/One_Name,
	$BlackOverlay/Background/Scorelist/Two_Name,
	$BlackOverlay/Background/Scorelist/Three_Name,
	$BlackOverlay/Background/Scorelist/Four_Name,
	$BlackOverlay/Background/Scorelist/Five_Name
	]

onready var highscore_records = [
	$BlackOverlay/Background/Scorelist/One_Score,
	$BlackOverlay/Background/Scorelist/Two_Score,
	$BlackOverlay/Background/Scorelist/Three_Score,
	$BlackOverlay/Background/Scorelist/Four_Score,
	$BlackOverlay/Background/Scorelist/Five_Score
]

func _ready() -> void:
	if Globals.connect("open_highscores", self, "_toggle_open") != OK: Globals.error_connect(self.name)

func _update_highscores(highscores = Highscores.load_highscores()) -> void:
	for score in highscores:
		highscore_names[score["id"]].text = score["name"]
		highscore_records[score["id"]].text = score["record"]

func _toggle_open() -> void:
	var new_pause_state = not get_tree().paused
	if new_pause_state: 
		_update_highscores()
		Music.play_audio($SFX_Player, Music.sounds_total[3].path)
	else:
		Music.play_audio($SFX_Player, Music.sounds_total[4].path)
	get_tree().paused = new_pause_state
	visible = new_pause_state
	Globals.pause(new_pause_state)
