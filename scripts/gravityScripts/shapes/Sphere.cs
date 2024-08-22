using Godot;
using System;
using System.Dynamic;

public partial class Sphere : GravityField
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	public override Vector3 get(Vector3 point){
		return (GlobalPosition - point).Normalized();
	}
}
