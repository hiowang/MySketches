class Rect{
  float x,y,w,h;
  boolean contains(float a,float b){
    return a>x&&a<x+w&&b>y&&b<y+h;
  }
  void display(){
    noFill();
    stroke(255,10);
    rect(x,y,w,h);
  }
  Rect(float a,float b,float c,float d){
    x=a;
    y=b;
    w=c;
    h=d;
  }
  ArrayList<Rect>divide(){
    ArrayList<Rect>r=new ArrayList<Rect>();
    r.add(new Rect(x,y,w/2,h/2));
    r.add(new Rect(x+w/2,y,w/2,h/2));
    r.add(new Rect(x,y+h/2,w/2,h/2));
    r.add(new Rect(x+w/2,y+h/2,w/2,h/2));
    return r;
  }
  float area(){
    return w*h;
  }
}

ArrayList<Rect>rects;

void setup(){
  size(750,750);
  rects=new ArrayList<Rect>();
  rects.add(new Rect(0,0,width,height));
}
void mousePressed(){
  addPoint(mouseX,mouseY);
}
void addPoint(float x,float y){
  process(x,y);
  points.add(new PVector(x,y));
}
void process(float x,float y){
  Rect r=iterate(x,y);
  if(r==null)return;
  while(r.area()>3){
    r=iterate(x,y);
    if(r==null)return;
  }
}
Rect iterate(float x,float y){
  ArrayList<Rect>validRects=new ArrayList<Rect>();
  for(Rect r:rects){
    if(r.contains(x,y))validRects.add(r);
  }
  if(validRects.size()==0)return null;
  Rect rect=validRects.get(0);
  float area=1000000;
  for(Rect r:validRects){
    if(r.area()<area){
      area=r.area();
      rect=r;
    }
  }
  rects.addAll(rect.divide());
  return rect;
}
void mouseDragged(){
  //if(frameCount%50==0)addPoint(mouseX,mouseY);
  if(Math.random()<0.05)addPoint(mouseX,mouseY);
}
ArrayList<PVector>points=new ArrayList<PVector>();
void draw(){
  background(0);
  //addPoint(random(width),random(height));
  strokeWeight(1);
  for(Rect r:rects)r.display();
  beginShape();
  stroke(255,255);
  //curveTightness(-5);
  if(points.size()>0)curveVertex(points.get(0).x,points.get(0).y);
  for(PVector p:points){
    curveVertex(p.x,p.y);
  }
  if(points.size()>0)curveVertex(points.get(points.size()-1).x,points.get(points.size()-1).y);
  endShape();
}