extends Node3D

@export var recoil_ammount: Vector3
@export var snap_amount: float
@export var speed: float

var current_rotation: Vector3
var target_rotation: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	target_rotation = lerp(target_rotation, Vector3.ZERO, speed * delta)
	current_rotation = lerp(current_rotation, target_rotation, snap_amount * delta)
	basis = Quaternion.from_euler(current_rotation)


func add_recoil() -> void:
	target_rotation += Vector3(recoil_ammount.x, randf_range(-recoil_ammount.y, recoil_ammount.y), randf_range(-recoil_ammount.z, recoil_ammount.z))
