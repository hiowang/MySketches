class Rect{
  int x,y,w,h;
  ArrayList<Rect>divide(){
    ArrayList<Rect>list=new ArrayList<Rect>();
    list.add(new Rect(x,y,w/2,h/2));
    list.add(new Rect(x+w/2,y,w/2,h/2));
    list.add(new Rect(x,y+h/2,w/2,h/2));
    list.add(new Rect(x+w/2,y+h/2,w/2,h/2));
    return list;
  }
  color col;
  void display(){
    fill(col);
    if(doStroke)stroke(0,20);
    else noStroke();
    //fill(100-error()/100000000,0,0);
    if(doRect)rect(x,y,w,h);
    else ellipse(x+w/2,y+h/2,w,h);
  }
  float area(){
    return w*h;
  }
  float err;
  float error(){
    float avgr,avgg,avgb;
    avgr=avgg=avgb=0;
    for(int a=x;a<x+w;a++){
      for(int b=y;b<y+h;b++){
        color col=img.get(a,b);
        avgr+=red(col);
        avgg+=green(col);
        avgb+=blue(col);
      }
    }
    float diffr,diffg,diffb;
    diffr=diffg=diffb=0;
    for(int a=x;a<x+w;a++){
      for(int b=y;b<y+h;b++){
        color col=img.get(a,b);
        diffr+=avgr-red(col);
        diffg+=avgg-green(col);
        diffb+=avgb-blue(col);
      }
    }
    return (diffr+diffg+diffb)/pow(area(),1.5);
  }
  Rect(int a,int b,int c,int d){
    col=img.get(a,b);
    x=a;
    y=b;
    w=c;
    h=d;
  }
}
PImage img;
void settings(){
  img=loadImage("wave2.jpg");
  size(img.width,img.height);
  rects.add(new Rect(0,0,width,height));
}
boolean doStroke=true;
boolean doRect=true;
void setup(){
  
}
float errThreshold=5000;
float areaThreshold=16;
void keyPressed(){
  if(key=='s')doStroke=!doStroke;
  if(key=='r')doRect=!doRect;
}
void mousePressed(){
  long start,end;
  start=System.currentTimeMillis();
  while(iterate()>errThreshold);
  end=System.currentTimeMillis();
  println((end-start));
}
float iterate(){
  //ArrayList<Rect>list=new ArrayList<Rect>();
  Rect largestErr=rects.get(0);
  float err=0;
  for(Rect r:rects){
    float e=r.error();
    if(e>err){
      largestErr=r;
      err=e;
    }
    //color topleft=r.col;
    //color topright=img.get(r.x+r.w,r.y);
    //color botleft=img.get(r.x,r.y+r.h);
    //color botright=img.get(r.x+r.w,r.y+r.h);
    //ArrayList<Rect>children=r.divide();
    ////if(rdiff(topleft,topright)>30||rdiff(topleft,botleft)>30||rdiff(topleft){
    //float d=0;
    //d+=diff(topleft,topright);
    //d+=diff(topleft,botright);
    //d+=diff(topleft,botleft);
    //d+=diff(topright,botright);
    //d+=diff(botleft,botright);
    //d+=diff(topright,botleft);
    //if(d>100){
    //  list.addAll(children);
    //}else{
    //  list.add(r);
    //}
  }
  if(err<errThreshold)return err;
  println(err);
  if(largestErr.area()<areaThreshold)return err;
  rects.remove(largestErr);
  rects.addAll(largestErr.divide());
  return err;
  //rects.clear();
  //rects.addAll(list);
}
float diff(color a,color b){
  //return color(red(a)-red(b),green(a)-green(b),blue(a)-blue(b));
  return rdiff(a,b)+gdiff(a,b)+bdiff(a,b);
}
float rdiff(color a,color b){
  return abs(red(a)-red(b));
}
float gdiff(color a,color b){
  return abs(green(a)-green(b));
}
float bdiff(color a,color b){
  return abs(blue(a)-blue(b));
}
ArrayList<Rect>rects=new ArrayList<Rect>();

void draw(){
  background(255);
  for(int i=0;i<5;i++)iterate();
  for(Rect r:rects)r.display();
  surface.setTitle("ImageCompressionQuadTree, frame rate="+nf(frameRate,2,3)+", frame count="+frameCount+", number rects="+rects.size());
}