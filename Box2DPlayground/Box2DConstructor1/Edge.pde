class Edge{
  Mass a;
  Mass b;
  Edge(Mass m1,Mass m2,float dist,float tension){
    a=m1;
    b=m2;
    DistanceJointDef djd=new DistanceJointDef();
    djd.bodyA=a.body;
    djd.bodyB=b.body;
    djd.length=box2d.scalarPixelsToWorld(dist);
    djd.frequencyHz=tension;
    djd.dampingRatio=0;
    DistanceJoint dj=(DistanceJoint)box2d.world.createJoint(djd);
    //println(dj);
    
    
  }
  //DistanceJoint dj;
  void display(){
    Vec2 posa=box2d.getBodyPixelCoord(a.body);
    Vec2 posb=box2d.getBodyPixelCoord(b.body);
    stroke(theme.edgeColor);
    line(posa.x,posa.y,posb.x,posb.y);
  }
}