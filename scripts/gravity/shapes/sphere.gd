@tool
extends gravityField

func _ready() -> void:
	
	flow.instantiate()
	pass

func getGrav(pos: Vector3, planet: planetDir) -> Vector3:
	var grav:Vector3 = (global_position - pos).normalized()
	
	var forwardCross = cam.forward().cross(grav)
	var rightCross = cam.right().cross(grav)
	var upCross = grav.cross(cam.up())
	
	planet.forward = cam.up().dot(forwardCross) * forwardCross + absf(cam.up().dot(rightCross)) * rightCross
	planet.right = cam.right().dot(forwardCross) * forwardCross + absf(cam.right().dot(upCross)) * upCross
	
	return grav
