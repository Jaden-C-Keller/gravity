using Godot;
using System;

public partial class Torus : GravityField
{
	[Export]
	float radius = 0.75f;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		radius *= 3f;
		GD.Print(GetParentNode3D().Transform.Basis.Y);
	}

    public override Vector3 get(Vector3 point)
    {
		Vector3 newPoint = point - (point - Position).Dot(Transform.Basis.Y) * Transform.Basis.Y;
		newPoint = Position + newPoint.Normalized() * radius;
        return (newPoint - point).Normalized();
		// return Vector3.Zero;
    }
}
