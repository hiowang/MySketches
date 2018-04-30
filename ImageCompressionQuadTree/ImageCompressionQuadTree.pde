class Rect{
  float x,y,w,h;
  ArrayList<Rect>divide(){
    ArrayList<Rect>list=new ArrayList<Rect>();
    list.add(new Rect(x,y, w/2,h/2));
    list.add(new Rect(x+w/2,y, w/2,h/2));
    list.add(new Rect(x,y+h/2, w/2,h/2));
    list.add(new Rect(x+w/2,y+h/2, w/2,h/2));
    return list;
  }
  color col;
  void display(){
    fill(col);
    if(doStroke)stroke(0,125);
    else noStroke();
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
    float area=1;
    for(float a=x;a<x+w;a++){
      for(float b=y;b<y+h;b++){
        color col=img.get(int(map(a,0,width,0,img.width)),int(map(b,0,height,0,img.height)));
        avgr+=red(col)/area;
        avgg+=green(col)/area;
        avgb+=blue(col)/area;
      }
    }
    //avgr/=area();
    //avgg/=area();
    //avgb/=area();
    float diffr,diffg,diffb;
    diffr=diffg=diffb=0;
    for(float a=x;a<x+w;a++){
      for(float b=y;b<y+h;b++){
        color col=img.get(int(map(a,0,width,0,img.width)),int(map(b,0,height,0,img.height)));
        diffr+=((float)avgr-red(col))/area;
        diffg+=((float)avgg-green(col))/area;
        diffb+=((float)avgb-blue(col))/area;
      }
    }
    //diffr/=area();
    //diffg/=area();
    //diffb/=area();
    return (diffr+diffg+diffb)/area()*100;
    ///pow(area(),1);
  }
  Rect(float a,float b,float c,float d){
    col=img.get(int(map(a,0,width,0,img.width)),int(map(b,0,height,0,img.height)));
    x=a;
    y=b;
    w=c;
    h=d;
  }
}
PImage img;
void settings(){
  img=loadImage("wave1.jpg");
  size(1024,1024);
  rects.add(new Rect(0,0,img.width,img.height));
}
boolean doStroke=false;
boolean doRect=true;
void setup(){
  
}
float errThreshold=100000000;
float areaThreshold=16;
void keyPressed(){
  if(key=='s')doStroke=!doStroke;
  if(key=='r')doRect=!doRect;
  if(key==' ')doIterate=!doIterate;
}
boolean doIterate=false;
void mousePressed(){
  //long start,end;
  //errThreshold-=1000;
  //start=System.currentTimeMillis();
  //int n=20;
  //end=System.currentTimeMillis();
  //println((end-start));
}
float iterate(){
  num++;
  Rect largestErr = rects.get(0);
  float err=0;
  for(Rect r:rects){
    if(r.area()<areaThreshold)continue;
    float e=r.error();
    if(e<errThreshold)continue;
    if(e>=err){
      largestErr=r;
      err=e;
    }
  }
  if(err<errThreshold)return err;
  println(err-errThreshold);
  lastErrDiff=err-errThreshold;
  if(largestErr.area()<areaThreshold)return err;
  rects.remove(largestErr);
  rects.addAll(largestErr.divide());
  return err;
}
float lastErrDiff=0;
float diff(color a,color b){
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
int num=0;
void draw(){
  //if(doIterate)iterate();
  
  if(iterate()>errThreshold)for(int i=0;i<2;i++)iterate();
  background(255);
  for(Rect r:rects)r.display();
  surface.setTitle("ImageCompressionQuadTree, frame rate="+nf(frameRate,2,3)+", frame count="+frameCount+", number rects="+rects.size()+", err left: "+nf(lastErrDiff,13,0));
}