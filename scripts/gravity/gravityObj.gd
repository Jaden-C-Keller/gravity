@tool
class_name gravityObj extends CharacterBody3D
class planetDir:
	var forward := Vector3.FORWARD
	var right := Vector3.RIGHT
	
	func normalize():
		forward = forward.normalized()
		right = right.normalized()
	
	func negate():
		forward *= -1
		right *= -1

@export
var gravStrength: float = 1.5

var planet: planetDir
var list: Array[gravityField]
var grav := Vector3.DOWN
var oldGrav: Vector3
var rot: Quaternion

func _ready() -> void:
	collision_layer = 3
	planet = planetDir.new()

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	oldGrav = grav
	getGrav()
	
	if grav == Vector3.ZERO:
		grav = Vector3.DOWN
	
	up_direction = -grav
	
	rot = Quaternion(oldGrav, grav).normalized()
	if oldGrav.dot(grav) > 0:
		velocity = rot * velocity
	
	velocity += grav * gravStrength * delta
	move_and_slide()
	velocity -= (velocity - velocity.dot(grav) * grav)

func add(field: gravityField):
	for i in list.size():
		if field.priority >= list[i].priority:
			list.insert(i, field)
			return
	list.append(field)

func remove(field: gravityField):
	list.erase(field)

func getGrav():
	grav = Vector3.ZERO
	for field in list:
		grav = field.getGrav(position, planet).normalized()
		planet.normalize()
		if grav != Vector3.ZERO:
			return

#@export
#var debugField: gravityField
#func _process(_delta):
	#print(type_string(typeof(debugField)))
	#if Engine.is_editor_hint() and debugField != null:
		#return
		#debugField.test()
		#debugField.getGrav(position, planet)
		#DebugDraw3D.draw_arrow_ray(position, planet.forward, 1)
		#DebugDraw3D.draw_arrow_ray(position, planet.right, 1)
