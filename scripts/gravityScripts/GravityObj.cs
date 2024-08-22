using System;
using System.Collections.Generic;
using Godot;

public abstract partial class GravityObj : CharacterBody3D{
    public GravityList list;
    protected Vector3 grav = Vector3.Down;

    public override void _Ready(){
        list = new GravityList();
    }

    public override void _PhysicsProcess(double delta)
    {
        grav = list.get(GlobalPosition);

        if(grav == Vector3.Zero){
            grav = Vector3.Down;
        }

        Velocity += grav * (float)delta;
        UpDirection = -grav;
        Velocity = Velocity.LimitLength(10f);
        MoveAndSlide();
    }
}