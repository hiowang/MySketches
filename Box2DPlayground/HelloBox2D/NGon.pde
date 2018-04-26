class NGon extends Thing {
  void display() {
    fill(0,0,100);
    //noStroke();
    stroke(255);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    if (!dynamic) {
      fill(50);
      noStroke();
    }
    beginShape();
    for(int i=0;i<n;i++){
      Vec2 v=ps.getVertex(i);
      //Vec2 newV=box2d.coordWorldToPixels(v.x,v.y);
      //vertex(newV.x,newV.y);
      vertex(box2d.scalarWorldToPixels(v.x),box2d.scalarWorldToPixels(v.y));
    }
    //vertex(0,0);
    //vertex(0,s);
    //vertex(s,0);
    endShape(CLOSE);
    //ellipse(0, 0, s*2, s*2);
    popMatrix();
  }
  float s;
  int n;
  NGon(float x, float y, int num,float s, boolean dynamic) {
    this(x, y, num,s, dynamic, 0, 0, 0);
  }
  PolygonShape ps;
  void destroy(){
    box2d.destroyBody(body);
  }
  NGon(float x, float y, int num,float _s, boolean dynamic, float vx, float vy, float angVel) {
    //x+=_w;
    //y+=_h;
    //x+=_s;
    //y+=_s;
    s=_s;
    n=num;
    this.dynamic=dynamic;
    BodyDef bd=new BodyDef();
    Vec2 center=box2d.coordPixelsToWorld(x, y);
    bd.position.set(center);
    bd.fixedRotation=false;
    bd.linearDamping=0.8;
    bd.angularDamping=0.9;
    bd.bullet=false;
    if (dynamic)bd.type=BodyType.DYNAMIC;
    else bd.type=BodyType.STATIC;

    body=box2d.createBody(bd);
    body.setLinearVelocity(new Vec2(vx, vy));
    body.setAngularVelocity(angVel);

    //Cir ps=new PolygonShape();
    //Vec2 size=box2d.coordPixelsToWorld(w,h);
    //println(size.x+" "+size.y);
    //w=_w;
    //h=_h;
    //_w=box2d.scalarPixelsToWorld(s);
    //_h=box2d.scalarPixelsToWorld(s);
    //_s=box2d.scalarPixelsToWorld(s)/2;
    ps=new PolygonShape();
    //ps.vertexCount=3;
    Vec2[]arr=new Vec2[n];
    for(int i=0;i<n;i++){
      float ang=TWO_PI*i/n;
      arr[i]=new Vec2(cos(ang)*s/2,sin(ang)*s/2);
    }
    ps.set(arr,n);
    //ps.set(new Vec2[]{new Vec2(0,0),new Vec2(0,_s),new Vec2(_s,0)},3);
    //ps.set(new V

    //polygon.Set(vertices, count);
    //CircleShape ps=new CircleShape();
    //ps.setRadius(_w/2+_h/2);
    //ps.setAsEllipse(_w,_h);

    FixtureDef fd=new FixtureDef();
    fd.shape=ps;
    fd.friction=0;
    fd.restitution=0.75;
    fd.density=1000;

    body.createFixture(fd);
  }
}