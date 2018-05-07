ArrayList<PVector>points=new ArrayList<PVector>();

class Line {
  PVector a, b;
  Line(PVector p1, PVector p2) {
    a=p1.copy();
    b=p2.copy();
  }
}
void setup() {
  size(1024,1024);
  for(int i=0;i<30;i++){
    points.add(new PVector(random(width),random(height)));
  }
  calcTree();
}
void calcTree(){
  ArrayList<Integer>nums=new ArrayList<Integer>();
  for(int i=0;i<points.size();i++)nums.add(i);
  while(nums.contains(1)){//lower number wins, while there is a lower number
    
  }
}
ArrayList<Line>tree;
void draw() {
  background(255);
  for(Line l:tree){
    stroke(0);
    line(l.a.x,l.a.y,l.b.x,l.b.y);
  }
  for(PVector p:points){
    fill(0);
    noStroke();
    ellipse(p.x,p.y,5,5);
  }
}