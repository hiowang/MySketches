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
int dens=16;
void mousePressed() {
  addPoint(new PVector(mouseX, mouseY));
}
void addPoint(PVector p) {
  points.add(p);
  colorMode(HSB, 100);
  cols.add(color(random(100), 50, 100));
  colorMode(RGB, 255);

  doCalculationsForPoint(p);
  calcVoronoiPolygons();
  calcCols();
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
  background(200);
  startTimer();
  int selectedIndex=0;
  for (int x=0; x<width/dens; x++) {
    for (int y=0; y<height/dens; y++) {
      fill(vorCols[x][y]);
      stroke(vorCols[x][y]);
      if (int(mouseX/dens)==x&&int(mouseY/dens)==dens) {
        selectedIndex=cols.indexOf(vorCols[x][y]);
        fill(0);
      }
      rect(x*dens, y*dens, dens, dens);
    }
  }

  for (PVector p : points) {
    displayPoint(p, 255);
  }
  for (Triangle t : triangulation) {
    ArrayList<PVector>p=t.getPoints();
    if (p.contains(rem1)||p.contains(rem2)||p.contains(rem3))continue;
    strokeWeight(5);
    t.display(color(0));
    strokeWeight(2);
    //  //displayPoint(t.p1,color(250));
    //  //displayPoint(t.p2,color(250));
    //  //displayPoint(t.p3,color(250));
    Circle c=t.circum();
    //c.display(color(50));
    strokeWeight(0);
  }
  for (Polygon p : voronoi) {
    strokeWeight(5);
    color col=cols.get(voronoi.indexOf(p));
    if (voronoi.indexOf(p)!=selectedIndex)col=color(0, 50);
    p.display(col);
    strokeWeight(1);
  }
  long l=endTimer();
  surface.setTitle("DelaunayTriangulation, frameRate= "+nf(frameRate, 2, 3)+" tpf in ms: "+l);
}
void displayPoint(PVector p, color col) {
  fill(col);
  noStroke();
  ellipse(p.x, p.y, 15, 15);
}