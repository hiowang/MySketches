ArrayList<PVector>points;
ArrayList<Integer>cols;
ArrayList<Triangle>triangulation;
ArrayList<Polygon>voronoi;


//TODO: Get voronoi diagram returning ArrayList<Line>

void setup() {
  size(1024, 1024);
  pixelDensity(2);
  points=new ArrayList<PVector>();
  cols=new ArrayList<Integer>();
  voronoi=new ArrayList<Polygon>();
  triangulation=new ArrayList<Triangle>();
  vorCols=new color[width/dens][height/dens];
  initTris();
}
int dens=2;
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
void mousePressed() {
  addPoint(new PVector(mouseX, mouseY));
}
void addPoint(PVector p) {
  drawn=false;
  //if (p.x>height-p.y)return;
  points.add(p);
  colorMode(HSB, 100);
  cols.add(color(random(100), 50, 100));
  colorMode(RGB, 255);
  //calcCols();
  //cols.add(color(random(255),random(255),random(255)));
}
color[][]vorCols;
color invCol(color c) {
  return color(255-red(c), 255-green(c), 255-blue(c));
}
long start, end;
void startTimer() {
  start=System.currentTimeMillis();
}
long endTimer() {
  end=System.currentTimeMillis();
  return end-start;
}
boolean drawn=false;
void draw() {
  if (drawn)return;
  println("NEW DRAW");
  drawn=true;
  surface.setTitle("DelaunayTriangulation, frameRate= "+nf(frameRate, 2, 3));
  background(200);
  calcCols();
  for(int x=0;x<width/dens;x++){
    for(int y=0;y<height/dens;y++){
      //fill(vorCols[x][y]);
      //stroke(vorCols[x][y]);
      //rect(x*dens,y*dens,dens,dens);
    }
  }
  
  startTimer();
  for (PVector p : points) {
    //displayPoint(p, invCol(cols.get(points.indexOf(p))));
    displayPoint(p, 255);
  }
  println("Points displaying: "+endTimer());
  startTimer();
  doTriangulation();
  calcVoronoiPolygons();
  println("Calculations: "+endTimer());
  startTimer();
  for (Triangle t : triangulation) {
    strokeWeight(5);
    t.display(color(0));
    strokeWeight(2);
    //  //displayPoint(t.p1,color(250));
    //  //displayPoint(t.p2,color(250));
    //  //displayPoint(t.p3,color(250));
      Circle c=t.circum();
      c.display(color(50));
      strokeWeight(0);
  }
  for (Polygon p : voronoi) {
    strokeWeight(5);
    //p.display(color(0,50));
    strokeWeight(1);
  }
  println("End display "+triangulation.size()+ " triangles and "+voronoi.size()+" polygons: "+endTimer());
}
void displayPoint(PVector p, color col) {
  fill(col);
  noStroke();
  ellipse(p.x, p.y, 15, 15);
}