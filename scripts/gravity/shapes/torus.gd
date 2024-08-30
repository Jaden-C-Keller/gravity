extends gravityField

@export
var radius:float = 0.75

func _ready() -> void:
	super()
	radius *= global_basis.x.length()

func getGrav(pos: Vector3, planet: gravityObj.planetDir) -> Vector3:
	var normal:Vector3 = global_basis.y.normalized()
	var point:Vector3 = pos - (pos - global_position).dot(normal) * normal;
	var toPoint:Vector3 = (point - global_position).normalized()
	point = global_position + toPoint * radius;
	var grav:Vector3 = (point-pos).normalized()
	
	var cross = grav.cross(toPoint)
	var rightGrav = cam.right().cross(grav)
	var upGrav = grav.cross(cam.up())
	planet.forward = cam.up().dot(cross) * cross + cam.up().dot(rightGrav) * rightGrav
	planet.right = cam.right().dot(cross) * cross + cam.right().dot(upGrav) * upGrav
	
	return grav
