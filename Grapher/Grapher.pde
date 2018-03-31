void setup(){
  size(1000,1000);
  gridSize=width/scale/2;
  //graphs.add(new Linear(1,0));//y=x
  graphs.add(new Quadratic(1,0,0));
  //graphs.add(new Fibonocci());
  //graphs.add(new Cubic(0.25,-1,1,-1));
  //graphs.add(new QuadraticMap());
  unitSize=width/gridSize;//=scale
}
float scale=30;
float unitSize;
float gridSize;
ArrayList<Graph> graphs=new ArrayList<Graph>();
void draw(){
  background(255);
  translate(width/2,height/2);
  scale(scale);
  strokeWeight(0.025);
  line(-gridSize,0,gridSize,0);
  line(0,-gridSize,0,gridSize);
  strokeWeight(0);
  for(float x=-gridSize;x<=gridSize;x++){
    float a=0.1;
    a=gridSize;
    line(-a,x,a,x);
    line(x,-a,x,a);
  }
  for(Graph g:graphs){
    
    float sizeInterp=g.sizeInterp();
    float tmin=g.getMinT();
    float tmax=g.getMaxT();
    noFill();
    stroke(0);
    strokeWeight(0.025);
    beginShape();
    plotPoint(g.getPos(tmin));
    for(float t=tmin;t<=tmax;t+=sizeInterp){
      plotPoint(g.getPos(t));
    }
    plotPoint(g.getPos(tmax));
    endShape();
    println("end graph");
  }
  println("end frame");
  //beginShape();
  //vertex(-1,0);
  //vertex(1,0);
  //endShape();
}
class QuadraticMap extends FunctionOfX{
  float sizeInterp(){
    return 10;
  }
  float f(float x){
    x/=10;
    if(x<=0)return 1;
    //if(x>=50)return 0;
    x=pow(f(x-1),2)+1;
    println(x);
    return x;
  }
}
float ma=100;
void plotPoint(PVector pos){
  if(pos.x>ma)pos.x=ma;
  if(pos.x<-ma)pos.x=-ma;
  if(pos.y>ma)pos.y=ma;
  if(pos.y<-ma)pos.y=-ma;
  curveVertex(pos.x,-pos.y);
}
abstract class Graph{
  float sizeInterp(){
    return 0.1;
  }
  abstract float getMinT();
  abstract float getMaxT();
  abstract PVector getPos(float t);
}

class Cubic extends FunctionOfX{
  float a,b,c,d;
  Cubic(float a,float b,float c,float d){
    this.a=a;
    this.b=b;
    this.c=c;
    this.d=d;
  }
  float f(float x){
    return a*x*x*x+b*x*x+c*x+d;
  }
}

class Fibonocci extends FunctionOfX{
  float a=(1+sqrt(5))/2;
  float b=(1-sqrt(5))/2;
  float f(float x){
    //x*=4;
    return (pow(a,x)-pow(b,x))/(a-b);
  }
}

class Quadratic extends FunctionOfX{
  float a,b,c;
  Quadratic(float a,float b,float c){
    this.a=a;
    this.b=b;
    this.c=c;
  }
  float f(float x){
    return a*x*x+b*x+c;
  }
}

class Linear extends FunctionOfX{
  float slope,offset;
  Linear(float s,float o){
    slope=s;
    offset=o;
  }
  float f(float x){
    return x*slope+offset;
  }
}

abstract class FunctionOfX extends Graph{//t=x
  float getMinT(){
    return -gridSize;
  }
  float getMaxT(){
    return gridSize;
  }
  abstract float f(float x);
  PVector getPos(float t){
    return new PVector(t,f(t));
  }
}