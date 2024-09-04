@tool
class_name flowVisual extends Node3D

@export
var field:gravityField

func _physics_process(_delta: float) -> void:
	var planet = gravityField.planetDir.new()
	if(field != null):
		field.getGrav(global_position, planet)
		#planet.normalize()
		DebugDraw3D.draw_line(global_position, global_position + planet.forward, Color(0,1,0))
		DebugDraw3D.draw_line(global_position, global_position + planet.right, Color(1,0,0))
		#DebugDraw3D.draw_arrow_ray(global_position, planet.forward, 0.3, Color(0,1,0),0.1)
		#DebugDraw3D.draw_arrow_ray(global_position, planet.right, 0.3, Color(1,0,0),0.1)
		
