using Godot;
using System;

public partial class Player : GravityObj
{

	Vector3 planetForward = Vector3.Forward, planetRight = Vector3.Right;
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);

		planetForward = cam.up().Cross(-grav).Cross(-grav);
		planetRight = cam.right().Cross(-grav).Cross(-grav);
		
		float right = Input.GetActionStrength("moveLeft") - Input.GetActionStrength("moveRight");
		float forward = Input.GetActionStrength("moveBackward") - Input.GetActionStrength("moveForward");


		// MoveAndCollide((planetForward * forward + planetRight * right) * (float)delta);
	}
}
