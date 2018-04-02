class Line{
  float sx,ex;
  float sy,ey;
  Line(float a,float b,float c,float d){
    sx=a;
    sy=b;
    ex=c;
    ey=d;
  }
  void display(boolean old){
    if(old)stroke(100);
    else stroke(255);
    line(sx,sy,ex,ey);
    stroke(255);
    if(abs(sx-ex)<10)return;
    line(sx,sy-5,sx,sy+5);
    line(ex,ey-5,ex,ey+5);
  }
}
ArrayList<Line>lines;
ArrayList<Line>oldLines;
void setup(){
  size(300,100);
  doInit();
  textFont(loadFont("Monospaced-20.vlw"));
}
void draw(){
  background(50);
  for(Line l:oldLines){
    l.display(true);
  }
  for(Line l:lines){
    l.display(false);
  }
  //textAlign(LEFT,TOP);
  //fill(255);
  //stroke(255);
  //text("Total difference: "+nfs(totalDiff,3,1),2,2);
}
void mousePressed(){
  doUpdate();
}
void keyPressed(){
  if(key==' ')doInit();
}
float variance;
float getRand(){
  float val=random(-variance,variance);
  val*=10;
  val=int(val);
  val/=10.0;
  return val;
}
float totalDiff=0;
void doUpdate(){
  totalDiff=0;
  oldLines.clear();
  ArrayList<Line>newLines=new ArrayList<Line>();
  for(int i=0;i<lines.size();i++){
    Line l=lines.get(i);
    float rand=getRand();
    totalDiff+=rand;
    //(sx,sy)-(ex,ey)
    //(sx,sy)-(sx/2+ex/2,ey+rand)
    //(sx/2+ex/2,sy+rand)-(ex,ey)
    float nx=l.sx/2+l.ex/2;
    float ny=l.sy/2+l.ey/2+rand;
    Line l1=new Line(l.sx,l.sy,nx,ny);
    Line l2=new Line(nx,ny,l.ex,l.ey);
    newLines.add(l1);
    newLines.add(l2);
    oldLines.add(l);
  }
  oldLines=lines;
  lines=newLines;
  variance*=dv;
  dv*=0.8;
}
float dv;
void doInit(){
  lines=new ArrayList<Line>();
  oldLines=new ArrayList<Line>();
  dv=0.8;
  variance=30;
  float r1=getRand();
  float r2=getRand();
  float r3=getRand();
  lines.add(new Line(0,r1+height/2,width/2,r2+height/2));
  lines.add(new Line(width/2,r2+height/2,width,r3+height/2));
}