class Mass{
  
  boolean dynamic;
  float mass;
  
  Mass(float x,float y,float mass,boolean dyn){
    dynamic=dyn;
    this.mass=mass;
    Vec2 center=box2d.coordPixelsToWorld(x,y);
    
    BodyDef bd=new BodyDef();
    bd.position.set(center);
    bd.fixedRotation=false;
    bd.linearDamping=0.8;
    bd.angularDamping=0.9;
    bd.bullet=false;
    if(dynamic)bd.type=BodyType.DYNAMIC;
    else bd.type=BodyType.STATIC;
    
    body=box2d.createBody(bd);
    body.setLinearVelocity(new Vec2(0,0));
    body.setAngularVelocity(0);
    
    CircleShape cs=new CircleShape();
    cs.setRadius(box2d.scalarPixelsToWorld(mass));
    
    FixtureDef fd=new FixtureDef();
    fd.shape=cs;
    fd.friction=0;
    fd.restitution=0.8;
    fd.density=1;
    
    body.createFixture(fd);
  }
  
  Body body;
  
  void display(){
    fill(100);
    stroke(125);
    Vec2 pos=box2d.getBodyPixelCoord(body);
    float ang=body.getAngle();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-ang);
    if(!dynamic){
      fill(255,0,0);
      stroke(255,0,0);
    }
    ellipse(0,0,mass*2,mass*2);
    popMatrix();
  }
  
}