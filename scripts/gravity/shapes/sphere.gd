@tool
extends gravityField

func getGrav(pos: Vector3, planet: gravityObj.planetDir) -> Vector3:
	var grav:Vector3 = (global_position - pos).normalized()
	#planet.forward = cam.up().cross(grav)
	#if planet.forward == Vector3.ZERO:
		#planet.forward = cam.right()
	#planet.forward = -planet.forward.cross(grav)
	#
	#planet.right = cam.right().cross(grav)
	#if planet.right == Vector3.ZERO:
		#planet.right = cam.up()
	#planet.right = -planet.right.cross(grav)
	
	var forwardCross = cam.forward().cross(grav)
	var rightCross = cam.right().cross(grav)
	var upCross = grav.cross(cam.up())
	
	planet.forward = cam.up().dot(forwardCross) * forwardCross + cam.up().dot(rightCross) * rightCross
	planet.right = cam.right().dot(forwardCross) * forwardCross + cam.right().dot(upCross) * upCross
	
	return grav
