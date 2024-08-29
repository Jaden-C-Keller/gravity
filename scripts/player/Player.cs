using Godot;
using System;

public partial class Player : GravityObj
{
	float speed = 50f;

	[Export]
	float jumpStrength = 1.0f;

	[Export]
	Node3D mesh;
	
	Vector3 planetForward = Vector3.Forward, planetRight = Vector3.Right;
	Vector3 move, lastMove = Vector3.Forward;
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Ready(){
		base._Ready();
	}

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);

		 //new Transform3D(new Basis(mesh.Transform.Basis.GetRotationQuaternion().Slerp(new Quaternion(UpDirection, 0), 0.5f)), mesh.Transform.Origin);
		//Transform = new Transform3D(new Basis(new Quaternion(UpDirection, 0f)), Transform.Origin);

		planetForward = cam.up().Cross(grav);
		if(planetForward == Vector3.Zero){
			planetForward = -cam.right();
		}
		planetForward = planetForward.Cross(grav).Normalized();


		planetRight = cam.right();
		if(planetRight == Vector3.Zero){
			planetRight = -cam.up();
		}
		planetRight = planetRight.Cross(grav).Cross(grav).Normalized();
		
		float right = Input.GetActionStrength("moveLeft") - Input.GetActionStrength("moveRight");
		float forward = Input.GetActionStrength("moveBackward") - Input.GetActionStrength("moveForward");

		if(Input.IsActionJustPressed("jump") && IsOnFloor()){
			vertVel = UpDirection * jumpStrength;
		}

		move = (planetForward * forward + planetRight * right).Normalized();

		if(cam.forward().Dot(UpDirection) < 0f){
			move *= -1;
		}

		lastMove = move == Vector3.Zero ? -lastMove.Cross(grav).Cross(grav) : move;

		mesh.Transform = mesh.Transform.InterpolateWith(mesh.Transform.LookingAt(lastMove, UpDirection), 5 * (float)delta);

		horzVel = move * speed * (float)delta;
		// MoveAndCollide(move * (float)delta);
	}
}
