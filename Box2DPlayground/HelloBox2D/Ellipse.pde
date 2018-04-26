class Ellipse extends Thing{
  void display(){
    fill(100,0,0);
    noStroke();
    //stroke(255);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(-a);
    if(!dynamic){
      fill(50);
      noStroke();
    }
    ellipse(0,0,w*2,h*2);
    popMatrix();
  }
  Body body;
  float w,h;
  boolean dynamic;
  Ellipse(float x,float y,float _w,float _h,boolean dynamic){
    this(x,y,_w,_h,dynamic,0,0,0);
  }
  Ellipse(float x,float y,float _w,float _h,boolean dynamic,float vx,float vy,float angVel){
    x+=_w;
    y+=_h;
    this.dynamic=dynamic;
    BodyDef bd=new BodyDef();
    Vec2 center=box2d.coordPixelsToWorld(x,y);
    bd.position.set(center);
    bd.fixedRotation=false;
    bd.linearDamping=0.8;
    bd.angularDamping=0.9;
    bd.bullet=false;
    if(dynamic)bd.type=BodyType.DYNAMIC;
    else bd.type=BodyType.STATIC;

    body=box2d.createBody(bd);
    body.setLinearVelocity(new Vec2(vx,vy));
    body.setAngularVelocity(angVel);

    //Cir ps=new PolygonShape();
    //Vec2 size=box2d.coordPixelsToWorld(w,h);
    //println(size.x+" "+size.y);
    w=_w;
    h=_h;
    _w=box2d.scalarPixelsToWorld(w);
    _h=box2d.scalarPixelsToWorld(h);
    CircleShape ps=new CircleShape();
    ps.setRadius(_w/2+_h/2);
    //ps.setAsEllipse(_w,_h);

    FixtureDef fd=new FixtureDef();
    fd.shape=ps;
    fd.friction=0;
    fd.restitution=0.75;
    fd.density=1;

    body.createFixture(fd);
  }
}