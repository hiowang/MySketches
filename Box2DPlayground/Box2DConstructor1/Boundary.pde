class Boundary{
  
  float x,y,w,h;
  
  Boundary(float x,float y,float w,float h){
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    //dynamic=dyn;
    //this.mass=mass;
    Vec2 center=box2d.coordPixelsToWorld(x,y);
    
    BodyDef bd=new BodyDef();
    bd.position.set(center);
    bd.fixedRotation=false;
    bd.linearDamping=0.8;
    bd.angularDamping=0.9;
    bd.bullet=false;
    bd.type=BodyType.STATIC;
    
    body=box2d.createBody(bd);
    body.setLinearVelocity(new Vec2(0,0));
    body.setAngularVelocity(0);
    
    PolygonShape ps=new PolygonShape();
    ps.setAsBox(box2d.scalarPixelsToWorld(w),box2d.scalarPixelsToWorld(h));
    
    FixtureDef fd=new FixtureDef();
    fd.shape=ps;
    fd.friction=0;
    fd.restitution=0.8;
    fd.density=1;
    
    body.createFixture(fd);
  }
  
  Body body;
  
  void display(){
    fill(200);
    stroke(200);
    Vec2 pos=box2d.getBodyPixelCoord(body);
    float ang=body.getAngle();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-ang);
    //ellipse(0,0,mass*2,mass*2);
    //rect(x-w/2,y-h/2,w,h);
    rect(-w,-h,w*2,h*2);
    popMatrix();
  }
  
}