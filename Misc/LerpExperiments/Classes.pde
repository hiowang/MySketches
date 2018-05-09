

abstract class PointProvider {
  abstract float x(float t);
  abstract float y(float t);
  void display(float frameT){
    fill(255);
    stroke(255);
    ellipse(x(frameT),y(frameT),15,15);
  }
}

class CircleProvider extends PointProvider{
  float cx=512,cy=512,r=100,speed=1;
  
  CircleProvider(float a,float b,float c,float d){
    cx=a;
    cy=b;
    r=c;
    speed=d;
  }
  
  float x(float t){
    if(t<0)t=0;
    return cx+r*cos(t*speed);
  }
  
  float y(float t){
    if(t<0)t=0;
    return cy+r*sin(t*speed);
  }
}

class LineDrawer {
  PointProvider a, b;
  float numPoints=5000;
  float delay;
  void display() {
    float frameT=frameCount*0.05;
    //float frameT=1.0;

    a.display(frameT);
    b.display(frameT);

    strokeWeight(2);
    stroke(255, 100);
    noFill();
    //beginShape();
    //vertex(x1(frameT),y1(frameT));
    for (int i=0; i<numPoints; i++) {
      float t=1.0*i/numPoints;
      //float d=delay*t;//0 to delay
      float d=(cos(map(t, 0, 1, 0, TWO_PI)+PI)+1)/2;
      float tt=frameT-d*delay;
      float x=lerp(a.x(tt), b.x(tt), t);
      float y=lerp(a.y(tt), b.y(tt), t);
      //curveVertex(x,y);
      point(x, y);
    }
  }
}