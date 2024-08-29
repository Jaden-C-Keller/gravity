using Godot;
using System;
using System.Dynamic;

public partial class Sphere : GravityField
{
	public override Vector3 get(Vector3 point){
		return (GlobalPosition - point).Normalized();
	}
}
