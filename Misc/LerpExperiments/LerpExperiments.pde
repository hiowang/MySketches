//Inspired by: https://necessarydisorder.wordpress.com/2018/03/31/a-trick-to-get-looping-curves-with-lerp-and-delay/
void setup(){
  size(1024,1024);
  pointA=new CircleProvider(200,512,100,1);
  pointB=new CircleProvider(824,512,100,5);
  line=new LineDrawer();
  line.a=pointA;
  line.b=pointB;
  line.delay=10;
}
LineDrawer line;

PointProvider pointA,pointB;

int numPoints=5000;

void draw(){
  background(0);
  line.display();
  //curveVertex(x2(frameT),y2(frameT));
  //endShape();
  
}