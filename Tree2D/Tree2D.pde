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
    int i=int(random(2,5));
    for(int n=0;n<i;n++){
      list.add(new Line(x1+random(-50,50),y1+random(-30,0),x1,y1,gen+1));
    }
    return list;
  }
}
ArrayList<Line>work=new ArrayList<Line>();
ArrayList<Line>finished=new ArrayList<Line>();
void setup(){
  size(500,500);
  work.add(new Line(width/2,300,width/2,height,0));
}
void iterate(){
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
    stroke(0,100);
    line(l.x1,l.y1,l.x2,l.y2);
  }
}