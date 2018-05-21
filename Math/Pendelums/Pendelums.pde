class OnePendelum {
  float x, y;
  float vx, vy;
  float grav=0.1;
  float rad=100;
  float ax,ay;
  OnePendelum() {
    x=100;
    y=10;
    vx=0;
    vy=0;
    ax=0;
    ay=0;
  }
  void update() {
    ax=0;
    ay=0;

    float mag=sqrt(x*x+y*y);
    if(abs(mag-rad)>10){
      x/=mag;
      y/=mag;
      //x*=lerp(rad,mag,0.1);
      //y*=lerp(rad,mag,0.1);
      //x
      x*=mag;
      y*=mag;
      float r=rad;
      if(mag<rad)r=mag-rad;
      float tensX=-1.0*x*mag/r;
      float tensY=-1.0*y*mag/r;
      float magT=sqrt(tensX*tensX+tensY*tensY);
      tensX/=magT;
      tensY/=magT;
      float f=0.7;
      ax+=tensX*f;
      ay+=tensY*f;
    }
    ay+=grav;

    vx+=ax;
    vy+=ay;
    x+=vx;
    y+=vy;
  }
  float x() {
    return x;
  }
  float y() {
    return y;
  }
  void display(float cx, float cy) {
    float angDiff=0;
    colorMode(HSB, 100);
    //color col=color(map(vx*v, -0.1, 0.1, 0, 100), 100, 100);
    //color col=color(map(dda,-0.001,0.001,0,100),100,100);
    color col=color(0);
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
OnePendelum a,b;
void draw() {
  fill(255, 10);
  stroke(255, 10);
  rect(0, 0, width, height);



  a.update();
  b.update();
  
  b.vx-=a.ax/2;
  b.vy-=a.ay/2;
  
  a.vx-=b.ax;
  a.vy-=b.ay;
  
  
  a.display(width/2, height/2);
  b.display(width/2+a.x,height/2+a.y);

  surface.setTitle("Pendelums, frameRate="+nf(frameRate, 2, 3));
}