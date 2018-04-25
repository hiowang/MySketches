class Box {
  void display() {
    fill(100);
    noStroke();
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    rect(0, 0, 10, 10);
    popMatrix();
  }
  Body body;
  Box(float x, float y, float w, float h, boolean dynamic, float vx, float vy, float angVel) {

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

    PolygonShape ps=new PolygonShape();
    //Vec2 size=box2d.coordPixelsToWorld(w, h);
    float scaledw=box2d.scalarPixelsToWorld(w),scaledh=box2d.scalarPixelsToWorld(h);
    println(scaledw+" "+scaledh);
    ps.setAsBox(scaledw,scaledh);

    FixtureDef fd=new FixtureDef();
    fd.shape=ps;
    fd.friction=0.3;
    fd.restitution=0.5;
    fd.density=1.0;

    body.createFixture(fd);
  }
}