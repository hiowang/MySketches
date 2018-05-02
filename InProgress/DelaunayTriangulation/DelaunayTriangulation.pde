ArrayList<PVector>points;
ArrayList<Integer>cols;
ArrayList<Triangle>triangulation;
ArrayList<Polygon>voronoi;


//TODO: Get voronoi diagram returning ArrayList<Line>

void setup() {
  size(500, 500);
  pixelDensity(2);
  points=new ArrayList<PVector>();
  cols=new ArrayList<Integer>();
  voronoi=new ArrayList<Polygon>();
  triangulation=new ArrayList<Triangle>();
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
  colorMode(HSB, 100);
  cols.add(color(random(100), 100, 100));
  colorMode(RGB, 255);
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
void draw() {
  surface.setTitle("DelaunayTriangulation, frameRate= "+nf(frameRate, 2, 3));
  background(255);
  //for(int x=0;x<width;x+=dens){
  //  for(int y=0;y<height;y+=dens){
  //    fill(vorCols[x/dens][y/dens]);
  //    noStroke();
  //    rect(x,y,dens,dens);
  //  }
  //}
  startTimer();
  for (PVector p : points) {
    displayPoint(p, invCol(cols.get(points.indexOf(p))));
  }
  println("Points displaying: "+endTimer());
  if (changedPoints) {
    doTriangulation();
    calcCols();
    calcVoronoiPolygons();
    changedPoints=false;
  }
  startTimer();
  for (Triangle t : triangulation) {
    t.display(0);
  }
  for (Polygon p : voronoi) {
    p.display(color(0, 0, 255));
  }
  println("End display triangles: "+endTimer());
}
void displayPoint(PVector p, color col) {
  fill(col);
  noStroke();
  ellipse(p.x, p.y, 15, 15);
}