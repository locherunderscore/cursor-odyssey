extends Node

var tracks_early = [
	{
	"id": 0,
	"index": 0,
	"name": "Strolling Without an Aim",
	"path": "res://assets/bgm/kimidori-vinyl.ogg"
	},{
	"id": 1,
	"index": 1,
	"name": "Courageous Dive",
	"path": "res://assets/bgm/mintchoco.ogg"
	},{
	"id": 2,
	"index": 2,
	"name": "Intergalactic Space Force",
	"path": "res://assets/bgm/mu.ogg"
	},{
	"id": 3,
	"index": 3,
	"name": "Rider of the Galaxy",
	"path": "res://assets/bgm/citron.ogg"
	},{
	"id": 4,
	"index": 4,
	"name": "Barefoot on Stardust",
	"path": "res://assets/bgm/sunshower.ogg"
	}
]

var tracks_mid = [
	{
	"id": 0,
	"index": 5,
	"name": "Hopelessly Lost",
	"path": "res://assets/bgm/fuchsia.ogg"
	},{
	"id": 1,
	"index": 6,
	"name": "Nightsky",
	"path": "res://assets/bgm/karakuri-night.ogg"
	},{
	"id": 2,
	"index": 7,
	"name": "In the Hopes of Meeting You",
	"path": "res://assets/bgm/lemondays.ogg"
	},{
	"id": 3,
	"index": 8,
	"name": "Passing the Slow Days",
	"path": "res://assets/bgm/marbles.ogg"
	},{
	"id": 4,
	"index": 9,
	"name": "Shooting Stars",
	"path": "res://assets/bgm/melolyn.ogg"
	},{
	"id": 5,
	"index": 10,
	"name": "Spending Time to Ponder",
	"path": "res://assets/bgm/godot.ogg"
	}
]

var tracks_late = [
	{
	"id": 0,
	"index": 11,
	"name": "Galactic Menace",
	"path": "res://assets/bgm/bbjam.ogg" 
	},{
	"id": 1,
	"index": 12,
	"name": "From Behind the Asteroid",
	"path": "res://assets/bgm/mataro.ogg"
	},{
	"id": 2,
	"index": 13,
	"name": "Scared of the Unknown",
	"path": "res://assets/bgm/murasaki.ogg"
	},{
	"id": 3,
	"index": 14,
	"name": "Blooming under Pressure",
	"path": "res://assets/bgm/crescent.ogg"
	},{
	"id": 4,
	"index": 15,
	"name": "Onwards, my Odyssey!",
	"path": "res://assets/bgm/unit241.ogg"
	}
]

var tracks_system = [
	{
	"id": 0,
	"index": 16,
	"name": "Titlescreen Theme",
	"path": "res://assets/bgm/frankenstein.ogg" 
	},{
	"id": 1,
	"index": 17,
	"name": "Options Theme",
	"path": "res://assets/bgm/pineapple.ogg"
	},{
	"id": 2,
	"index": 18,
	"name": "Gameover Theme",
	"path": "res://assets/bgm/kowloon.ogg"
	},{
	"id": 3,
	"index": 19,
	"name": "Credits Theme",
	"path": "res://assets/bgm/plumrain.ogg"
	}
]

### Sound Effects ###
var sfx_sounds_total = [
	{
	"id": 0,
	"name": "Explosion Debris",
	"path": "res://assets/sfx/explosion_debris.wav"
	},{
	"id": 1,
	"name": "Explosion Ship",
	"path": "res://assets/sfx/Explosion_ship.wav"
	},{
	"id": 2,
	"name": "Get Orb",
	"path": "res://assets/sfx/get_orb.wav"
	},{
	"id": 3,
	"name": "Menu Open",
	"path": "res://assets/sfx/Menu_Select.wav"
	},{
	"id": 4,
	"name": "Menu Close",
	"path": "res://assets/sfx/Menu_Select_2.wav"
	},{
	"id": 5,
	"name": "Menu Cancel",
	"path": "res://assets/sfx/Menu_Back.wav"
	}
]

var tracks_total = tracks_early + tracks_mid + tracks_late + tracks_system
var current_track = []

func set_current_track(lib_id: int, index: int, total_index: int) -> String:
	match lib_id:
		0: current_track = tracks_early[index]
		1: current_track = tracks_mid[index]
		2: current_track = tracks_late[index]
		_: current_track = tracks_total[total_index]
	return current_track.path

func list_of_tracks(lib_id: int, exclude_id: int) -> Array:
	var list = []
	var tracks = []
	match lib_id:
		0: tracks = tracks_early
		1: tracks = tracks_mid
		2: tracks = tracks_late
		_: tracks = tracks_total
	for track in tracks: if track.id != exclude_id: list.append(track.id)
	return list

func play_audio(audio_player: AudioStreamPlayer, audio_track: String, audio_mode: String = "SFX") -> void:
	var soundstream = load(audio_track)
	audio_player.set_stream(soundstream)
	audio_player.volume_db = linear2db(Globals.bgm_volume) if audio_mode == "BGM" else linear2db(Globals.sfx_volume)
	audio_player.play()
