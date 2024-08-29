using System;
using System.Collections.Generic;
using Godot;

public abstract partial class GravityObj : CharacterBody3D{
    [Export]
    protected float gravityStrength = 2.0f;
    GravityList list;
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

        UpDirection = -grav;
        if(Velocity != Vector3.Zero && grav != Vector3.Zero){
            int direction = Velocity.Dot(grav) < 0f ? -1 : 1;
            Velocity = new Quaternion(Velocity, grav * direction).Normalized() * Velocity;
        }

        // Velocity += grav * (float)delta;
        // MoveAndSlide();
        if(!MoveAndSlide()){
            Velocity += grav * gravityStrength * (float)delta;
        }
        else if(IsOnFloor()){
            Velocity = Vector3.Zero;
        }
    }

    public void add(GravityField field){
        list.add(field);
    }

    public void remove(GravityField field){
        list.remove(field);
    }
}