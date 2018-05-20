class OnePendelum {

  float grav=0.4;
  float rad=100;
  float angle;
  float vel=0;
  float velDamping=1;
  OnePendelum() {
    angle=random(-PI, PI);
  }
  void update() {
    float acc=-1*grav/rad*sin(angle);
    vel+=acc;
    angle+=vel;
  }
  float x() {
    return cos(angle+HALF_PI)*rad;
  }
  float y() {
    return sin(angle+HALF_PI)*rad;
  }
  void display(float cx, float cy) {
    float angDiff=0;
    colorMode(HSB, 100);
    color col=color(map(vel, -0.1, 0.1, 0, 100), 100, 100);
    //color col=color(map(dda,-0.001,0.001,0,100),100,100);
    //println(da+" "+dda);
    colorMode(RGB, 255);
    fill(col);
    stroke(col);
    translate(cx, cy);
    rotate(angDiff);
    line(0, 0, x(), y());
    ellipse(x(), y(), 5, 5);
    rotate(-angDiff);
    translate(-cx, -cy);
    stroke(0, 20);
  }
}

void setup() {
  size(500, 500);
  background(255);
  a=new OnePendelum();
  b=new OnePendelum();
}
OnePendelum a, b;
void draw() {
  fill(255, 10);
  stroke(255, 10);
  rect(0, 0, width, height);



  a.update();
  b.update();

  a.display(width/2, height/2);
  //b.display(width/2+a.x(100), height/2+a.y(100), 100, a.a);

  surface.setTitle("Pendelums, frameRate="+nf(frameRate, 2, 3));
}