class_name gravityField extends Area3D

func _ready() -> void:
	self.body_entered.connect(_entered)
	self.body_exited.connect(_exited)
	collision_layer = 2
	collision_mask = 2

func _entered(body):
	body.add(self)

func _exited(body):
	body.remove(self)

func getGrav(_pos: Vector3, _planet: gravityObj.planetDir) -> Vector3:
	return Vector3.ZERO
