ArrayList<PVector>points;
ArrayList<Integer>cols;
ArrayList<Triangle>tris;

//TODO: Get voronoi diagram returning ArrayList<Line>

void setup() {
  size(500, 500);
  pixelDensity(2);
  points=new ArrayList<PVector>();
  cols=new ArrayList<Integer>();
  tris=new ArrayList<Triangle>();
  vorCols=new color[width/dens][height/dens];
}
int dens=4;
void keyPressed() {
  int n=0;
  if (key=='1')n=1;
  if (key=='2')n=2;
  if (key=='3')n=5;
  if (key=='4')n=10;
  for (int i=0; i<n; i++) {
    addPoint(new PVector(random(width), random(height)));
  }
}
boolean changedPoints=false;
void mousePressed() {
  addPoint(new PVector(mouseX, mouseY));
}
void addPoint(PVector p) {
  //if (p.x>height-p.y)return;
  points.add(p);
  changedPoints=true;
  colorMode(HSB,100);
  cols.add(color(random(100),100,100));
  colorMode(RGB,255);
  //cols.add(color(random(255),random(255),random(255)));
}
color[][]vorCols;
void draw() {
  surface.setTitle("DelaunayTriangulation, frameRate= "+nf(frameRate,2,3));
  background(255);
  for(int x=0;x<width;x+=dens){
    for(int y=0;y<height;y+=dens){
      fill(vorCols[x/dens][y/dens]);
      noStroke();
      rect(x,y,dens,dens);
    }
  }
  
  for (PVector p : points) {
    displayPoint(p, 0);
  }
  if (changedPoints) {
    doTriangulation();
    calcCols();
    changedPoints=false;
  }
  for (Triangle t : tris) {
    color col1=t.isGood()?color(0, 100):color(255, 0, 0, 100);
    color col2=t.isGood()?color(0, 25):color(255, 0, 0, 25);
    col1=color(0);
    col2=color(0, 10);
    if (!t.isGood()) {
      col1=color(255, 0, 0);
      col2=color(0, 60);
      displayPoint(t.p1, color(255, 0, 0));
      displayPoint(t.p2, color(255, 0, 0));
      displayPoint(t.p3, color(255, 0, 0));
    }
    t.display(col1);
    //t.circum().display(col2);
    for(Triangle t1:tris){
      if(isAdjacent(t,t1)){
        PVector p1=t.center();
        PVector p2=t1.center();
        stroke(0,0,255);
        strokeWeight(20);
        line(p1.x,p1.y,p2.x,p2.y);
        strokeWeight(1);
      }
    }
  }
}
void displayPoint(PVector p, color col) {
  fill(col);
  noStroke();
  ellipse(p.x, p.y, 15, 15);
}