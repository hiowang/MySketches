class Entity{
  
  float w=25;
  float h=25;
  
  float speed=10;
  color col,stroke;
  
  Entity(float x,float y,color col,color stroke){
    this.col=col;
    this.stroke=stroke;
    bd=new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    bd.fixedRotation=false;
    bd.type=BodyType.DYNAMIC;
    bd.linearDamping=0.8;
    bd.angularDamping=1;
    bd.bullet=false;
    
    body=box2d.createBody(bd);
    
    ps=new PolygonShape();
    ps.setAsBox(box2d.scalarPixelsToWorld(w),box2d.scalarPixelsToWorld(h));
    
    fd=new FixtureDef();
    fd.shape=ps;
    fd.friction=0.3;
    fd.restitution=0.5;
    fd.density=1.0/w/h;
    
    body.createFixture(fd);
    
  }
  
  FixtureDef fd;
  
  PolygonShape ps;
  
  BodyDef bd;
  Body body;
  
  void applyForce(float x,float y){
    body.applyForce(new Vec2(x,y),new Vec2(0,0));
  }
  
  void update(){
  }
  
  void respondToKeys(){
    if(isA){
      applyForce(-speed,0);
    }
    if(isD){
      applyForce(speed,0);
    }
    if(isW){
      applyForce(0,speed);
    }
    if(isS){
      applyForce(0,-speed);
    }
    if(isSpace){
      Vec2 v=body.getLinearVelocity();
      float factor=0.9;
      body.setLinearVelocity(new Vec2(v.x*factor,v.y*factor));
    }
  }
  
  void display(){
    body.setAngularVelocity(body.getAngularVelocity()*0.1);
    Vec2 pos=box2d.getBodyPixelCoord(body);
    float a=body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(col);
    stroke(stroke);
    rect(-w,-h,w*2,h*2);
    popMatrix();
    
    //if(pos.x<0){
      //stroke(stroke);
      //line(0,pos.y,0,pos.y-30);
    //}
    float arrowHeight=0;
    float arrowWidth=10;
    float arrowLineLength=20;
    if(pos.y<0&&inRange(pos.x,0,width)){
      stroke(stroke);
      line(pos.x,0,pos.x,arrowHeight);
      line(pos.x,0,pos.x-arrowWidth,arrowLineLength);
      line(pos.x,0,pos.x+arrowWidth,arrowLineLength);
    }
    if(pos.y>height&&inRange(pos.x,0,width)){
      stroke(stroke);
      line(pos.x,height,pos.x,height-arrowHeight);
      line(pos.x,height,pos.x-arrowWidth,height-arrowLineLength);
      line(pos.x,height,pos.x+arrowWidth,height-arrowLineLength);
    }
  }
  
}
boolean inRange(float a,float mi,float ma){
  return a>mi&&a<ma;
}