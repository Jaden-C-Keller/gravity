using System;
using System.Collections.Generic;
using Godot;

public abstract partial class GravityObj : CharacterBody3D{
    [Export]
    protected float gravityStrength = 2.0f;
    GravityList list;
    protected Vector3 grav = Vector3.Down;
    protected Vector3 vertVel = Vector3.Zero;
    protected Vector3 horzVel = Vector3.Zero;

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
        if(vertVel != Vector3.Zero && grav != Vector3.Zero){
            int direction = vertVel.Dot(grav) < 0f ? -1 : 1;
            vertVel = new Quaternion(vertVel, grav * direction).Normalized() * vertVel;
        }

        Velocity = vertVel + horzVel;
        
        if(!MoveAndSlide()){
            vertVel += grav * gravityStrength * (float)delta;
        }
        else if(IsOnFloor()){
            vertVel = Vector3.Zero;
        }


    }

    public void add(GravityField field){
        list.add(field);
    }

    public void remove(GravityField field){
        list.remove(field);
    }
}