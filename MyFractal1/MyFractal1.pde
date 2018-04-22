class Rect {
  int x, y, w, h;
  boolean done=false;
  Rect(int a,int b,int c, int d){
    x=a;
    y=b;
    w=c;
    h=d;
  }
  void display() {
    noFill();
    //ellipseMode(CORNER);
    stroke(255,20);
    rect(x, y, w, h);
    stroke(255,40);
    ellipse(x,y,w,h);
  }
  //ArrayList<Rect>makeNew() {
  //  done=true;
  //  int nw=w/2;
  //  int nh=h/2;
  //  nw=w/2;
  //  nh=h/2;
  //  ArrayList<Rect>list=new ArrayList<Rect>();
  //  //list.add(new Rect(x, y, nw, nh));
  //  if(rand())list.add(aToB(x,y,x+nw,y+nh));
  //  if(rand())list.add(aToB(x+nw,y+nh,x+w,y+h));
  //  if(rand())list.add(aToB(x,y+nh,x+nw,y+h));
  //  if(rand())list.add(aToB(x+nw,y,x+w,y+nh));
  //  //list.add(new Rect(x+nw,y+nh,x+w,y+h));
  //  return list;
  //}
}
boolean rand(){
  return random(100)<75;
}
Rect aToB(int x,int y,int a,int b){
  return new Rect(x,y,a-x,b-y);
}
ArrayList<Rect>rects=new ArrayList<Rect>();
void drawFractal(int x, int y, int w, int h, int n) {
  if (n<0)return;
  noFill();
  stroke(255, 25);
  //line(x,y,x+w,y+h);
  //line(x+w,y,x,y+h);
  //ellipseMode(CENTER);
  //rectMode(CENTER);
  //ellipse(x,y,w*2,h*2);
  //rect(x, y, w, h);
  rects.add(new Rect(x,y,w,h));
  int nw=int(random(w));
  int nh=int(random(h));
  nw=w/2;
  nh=h/2;
  if(rand())drawFractal(x, y, nw, nh, n-1);
  if(rand())drawFractal(x+nw, y+nh, w-nw, h-nh, n-1);
  if(rand())drawFractal(x+nw, y, w-nw, nh, n-1);
  if(rand())drawFractal(x, y+nh, nw, h-nh, n-1);
}
int num=10;
void setup() {
  size(500, 500);
  background(0);
  //rects.add(new Rect(0,0,width,height));
  drawFractal(0, 0, width, height, num);
}
void draw(){
  background(0);
  for(Rect r:rects){
    r.display();
  }
}
void mousePressed(){
  rects.clear();
  drawFractal(0,0,width,height,num);
  //ArrayList<Rect>newRects=new ArrayList<Rect>();
  //for(Rect r:rects)newRects.addAll(r.makeNew());
  //rects.addAll(newRects);
}