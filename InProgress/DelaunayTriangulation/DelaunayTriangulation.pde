ArrayList<PVector>points;
ArrayList<Triangle>tris;

void setup(){
  size(500,500);
  points=new ArrayList<PVector>();
  tris=new ArrayList<Triangle>();
}
void mousePressed(){
  points.add(new PVector(mouseX,mouseY));
}
void draw(){
  background(255);
  doTriangulation();
  for(PVector p:points){
    fill(0);
    ellipse(p.x,p.y,5,5);
  }
  for(Triangle t:tris){
    color col1=t.isGood()?color(0,100):color(255,0,0,100);
    color col2=t.isGood()?color(0,25):color(255,0,0,25);
    t.display(col1);
    t.circum().display(col2);
  }
}