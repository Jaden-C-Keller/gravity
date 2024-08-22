using Godot;
using System;

public partial class cam : Camera3D
{
    public static cam instance;

    public override void _Ready()
    {
        instance = this;
    }

    public static Vector3 up(){
        return instance.Basis.Y;
    }

    public static Vector3 right(){
        return instance.Basis.Y;
    }
}
