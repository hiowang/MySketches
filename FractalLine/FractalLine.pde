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
  }
}
ArrayList<Line>lines;
ArrayList<Line>oldLines;
void setup(){
  size(1700,700);
  doInit();
}
void draw(){
  background(50);
  for(Line l:oldLines){
    l.display(true);
  }
  for(Line l:lines){
    l.display(false);
  }
}
void mousePressed(){
  doUpdate();
}
float variance=300;
float getRand(){
  return random(-variance,variance);
}
void doUpdate(){
  oldLines.clear();
  ArrayList<Line>newLines=new ArrayList<Line>();
  for(int i=0;i<lines.size();i++){
    Line l=lines.get(i);
    float rand=getRand();
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
float dv=0.8;
void doInit(){
  lines=new ArrayList<Line>();
  oldLines=new ArrayList<Line>();
  lines.add(new Line(0,height/2,width/2,height/2));
  lines.add(new Line(width/2,height/2,width,height/2));
}