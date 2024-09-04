class_name cam extends Camera3D
static var instance: cam

func _ready() -> void:
	instance = self

static func up() -> Vector3:
	if Engine.is_editor_hint():
		return Vector3.UP
	return instance.basis.y

static func right() -> Vector3:
	if Engine.is_editor_hint():
		return Vector3.RIGHT
	return instance.basis.x

static func forward() -> Vector3:
	if Engine.is_editor_hint():
		return Vector3.FORWARD
	return -instance.basis.z
