using System.ComponentModel;
using Godot;

class node{
    public GravityField field;
    public node next;

    public node(GravityField field, node n = null){
        this.field = field;
        next = n;
    }
}

public class GravityList{
    node first = null;

    public void add(GravityField field){
        for(node n = first; n != null; n = n.next){
            if(field.Priority >= n.field.Priority){
                n = new node(field, n);
            }
        }

        first = new node(field);
    }

    public void remove(GravityField field){
        for(node n = first; n != null; n = n.next){
            if(field == n.field){
                if(n.next == null){
                    n = null;
                }
                else{
                    n = n.next;
                }
            }
        }
    }

    public Vector3 get(Vector3 point){
        Vector3 v = Vector3.Zero;

        if(first == null){
            return v;
        }

        int top = first.field.Priority;
        for(node n = first; n != null; n = n.next){
            if(n.field.Priority < top && v != Vector3.Zero){
                break;
            }
            top = first.field.Priority;
            v += n.field.get(point);
        }
        return v.Normalized();
    }
}