extends Node3D


@onready var muzzle_flash: AnimatedSprite3D = $MuzzleSprite
@onready var omni: OmniLight3D = $FlashOmni

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_player_fire_acction_called():
	muzzle_flash.play("default")

func flash(value: bool) -> void:
	omni.visible = value
