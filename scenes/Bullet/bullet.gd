extends Node3D


var SPEED: float = 120.0

@onready var mesh: MeshInstance3D = $Mesh
@onready var ray_cast: RayCast3D = $RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	#if ray_cast.is_colliding():
		
