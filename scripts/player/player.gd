class_name player extends gravityObj

@export
var speed: float = 100

@export
var jumpStrength: float = 1

@export
var mesh: MeshInstance3D

var move := Vector3.ZERO
var lastMove: Vector3

func _ready() -> void:
	super()
	lastMove = -global_basis.z.normalized()

func _physics_process(delta: float) -> void:
	super(delta)
	
	var right:float = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	var forward:float =  Input.get_action_strength("moveForward") - Input.get_action_strength("moveBack")
	
	move = (planet.forward * forward + planet.right * right).normalized()
	move -= move.dot(grav) * grav
	
	velocity += move * speed * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity += up_direction * jumpStrength
	
	lastMove = move if move != Vector3.ZERO else rot * lastMove
	mesh.transform = mesh.transform.interpolate_with(mesh.transform.looking_at(lastMove, up_direction), 10 * delta)
	
