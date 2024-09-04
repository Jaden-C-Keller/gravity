@tool
class_name gravityField extends Area3D
var flow = preload("res://scripts/gravity/flow.tscn")

class planetDir:
	var forward := Vector3.FORWARD
	var right := Vector3.RIGHT
	
	func normalize():
		forward = forward.normalized()
		right = right.normalized()
	
	func negate():
		forward *= -1
		right *= -1

func _ready() -> void:
	self.body_entered.connect(_entered)
	self.body_exited.connect(_exited)
	collision_layer = 2
	collision_mask = 2

func _entered(body):
	body.add(self)

func _exited(body):
	body.remove(self)

func getGrav(_pos: Vector3, _planet: planetDir) -> Vector3:
	return Vector3.ZERO
