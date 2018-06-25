class Line{
  float x1,y1,x2,y2;
  int gen=0;
  Line(float a,float b,float c,float d,int g){
    x1=a;
    y1=b;
    x2=c;
    y2=d;
    gen=g;
  }
  ArrayList<Line>makeNew(){
    ArrayList<Line>list=new ArrayList<Line>();
    int i=int(random(2,2));
    for(int n=0;n<i;n++){
      list.add(new Line(x1+random(-xdiff,xdiff),y1-random(ydiff,ydiff+30),x1,y1,gen+1));
    }
    return list;
  }
}
float xdiff=100;
float ydiff=100;
ArrayList<Line>work=new ArrayList<Line>();
ArrayList<Line>finished=new ArrayList<Line>();
void setup(){
  size(500,500);
  //work.add(new Line(width/2,300,width/2,height,0));
  for(int i=0;i<3;i++){
    float r=10;
    float ang=radians(random(45,180-45));
    work.add(new Line(width/2,height,width/2+cos(ang)*r,0+sin(ang)*r,0));
  }
}
void iterate(){
  xdiff*=0.75;
  ydiff*=0.5;
  ArrayList<Line>newLines=new ArrayList<Line>();
  for(Line l:work){
    newLines.addAll(l.makeNew());
  }
  finished.addAll(work);
  work.clear();
  work.addAll(newLines);
  
}
void mousePressed(){
  iterate();
}
void draw(){
  background(255);
  for(Line l:finished){
    stroke(0,50);
    float a=0;
    line(l.x1+random(-a,a),l.y1+random(-a,a),l.x2+random(-a,a),l.y2+random(-a,a));
  }
}