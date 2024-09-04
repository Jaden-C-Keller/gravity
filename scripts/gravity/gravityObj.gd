class_name gravityObj extends CharacterBody3D

@export
var gravStrength: float = 1.5

var planet: gravityField.planetDir
var list: Array[gravityField]
var grav := Vector3.DOWN
var oldGrav: Vector3
var rot: Quaternion

func _ready() -> void:
	collision_layer = 3
	planet = gravityField.planetDir.new()

func _physics_process(delta: float) -> void:
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
		grav = field.getGrav(global_position, planet).normalized()
		#planet.normalize()
		if grav != Vector3.ZERO:
			return
