using Godot;

public abstract partial class GravityField : Area3D{
    public void entered(Node3D body){
        (body as GravityObj).list.add(this);
        
    }

    public void exited(Node3D body){
        (body as GravityObj).list.remove(this);
    }

    public abstract Vector3 get(Vector3 point);
}