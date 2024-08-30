class_name cam extends Camera3D
static var instance: cam

func _ready() -> void:
	instance = self

static func up() -> Vector3:
	return instance.basis.y

static func right() -> Vector3:
	return instance.basis.x

static func forward() -> Vector3:
	return -instance.basis.z
