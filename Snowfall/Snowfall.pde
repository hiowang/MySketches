class Flake {
  float x, y;
  float p1;
  float p2;
  float p3;
  float s;
  PGraphics graphics;
  Flake() {
    p1=int(random(5, 10));
    p2=random(0, 1);
    p3=int(random(40, 40));
    s=random(0.2, 0.3);
    graphics=createGraphics(200, 200);
    graphics.beginDraw();
    x=100;
    y=100;
    graphics.noFill();
    //stroke(255);
    graphics.stroke(map(s, 0, 0.3, 0, 255));
    graphics.translate(x, y);
    //scale(s);
    graphics.strokeWeight(1);

    graphics.beginShape();
    for (float a=0; a<TWO_PI*p1; a+=0.01) {
      float r=cos(p2*a)*p3;
      graphics.vertex(cos(a)*r, sin(a)*r);
    }
    graphics.endShape();
    graphics.translate(-x, -y);
    graphics.endDraw();
  }
  float vx=0;
  void update() {
    y+=6*s;
    vx+=map(noise(y*0.01,frameCount*0.1),0,1,-0.1,0.1);
    x+=vx*s;
  }
  void display() {
    image(graphics, x, y, 200*s, 200*s);
  }
}
ArrayList<Flake>flakes=new ArrayList<Flake>();

void setup() {
  size(500, 500);
  int w=5;
  int h=5;
  for (int i=0; i<20; i++) {
    Flake f=new Flake();
    f.x=random(50, width-50);
    //f.y=y*height/h+height/h/2;
    f.y=-50;
    //f.z=0;
    flakes.add(f);
  }
}
void draw() {
  background(0);
  println(frameRate);
  {
    Flake f=new Flake();
    f.x=random(50, width-50);
    //f.y=y*height/h+height/h/2;
    f.y=-50;
    //f.z=0;
    flakes.add(f);
  }
  for (Flake f : flakes) {
    f.display();
    f.update();
  }
}