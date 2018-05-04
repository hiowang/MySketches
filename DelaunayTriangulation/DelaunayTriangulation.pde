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
void keyPressed(){
  if(key=='1')drawDelaunay=!drawDelaunay;
  if(key=='2')drawCircum=!drawCircum;
  if(key=='3')drawColoredCells=!drawColoredCells;
  if(key=='4')drawVoronoi=!drawVoronoi;
  int n=0;
  if(key=='5'){
    n=1;
  }
  if(key=='6'){
    n=2;
  }
  if(key=='7'){
    n=5;
  }
  if(key=='8'){
    n=10;
  }
  if(key=='9'){
    n=20;
  }
  if(key=='0'){
    n=50;
  }
  for(int i=0;i<n;i++)addPoint(new PVector(random(100,width-100),random(100,height-100)));
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
boolean drawDelaunay=false;
boolean drawCircum=false;
boolean drawColoredCells=true;
boolean drawVoronoi=true;
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
int mx=-1;
int my=-1;
void draw() {
  background(200);
  //startTimer();
  //int selectedIndex=0;
  if (drawColoredCells) {
    for (int x=0; x<width/dens; x++) {
      for (int y=0; y<height/dens; y++) {
        fill(vorCols[x][y]);
        stroke(vorCols[x][y]);
        //if (int(mouseX/dens)==x&&int(mouseY/dens)==dens) {
        //fill(0);
        //}
        rect(x*dens, y*dens, dens, dens);
      }
    }
  }
  //long l1=endTimer();
  //startTimer();

  for (PVector p : points) {
    displayPoint(p, 255);
  }
  for (Triangle t : triangulation) {
    ArrayList<PVector>p=t.getPoints();
    if (p.contains(rem1)||p.contains(rem2)||p.contains(rem3))continue;
    strokeWeight(5);
    if(drawDelaunay)t.display(color(50));
    strokeWeight(2);
    //  //displayPoint(t.p1,color(250));
    //  //displayPoint(t.p2,color(250));
    //  //displayPoint(t.p3,color(250));
    Circle c=t.circum();
    if(drawCircum)c.display(color(0,20));
    strokeWeight(0);
  }
  if (drawVoronoi) {
    Polygon thePoly=null;
    for (Polygon p : voronoi) {
      strokeWeight(5);
      color col=color(255, 0, 0);
      //if (voronoi.indexOf(p)!=selectedIndex)col=color(0, 50);
      boolean best=isBest(points.get(voronoi.indexOf(p)), mx, my);
      if (best)thePoly=p;
      else col=color(0);
      if (thePoly==p)continue;
      p.display(col);
      strokeWeight(1);
    }
    if (thePoly!=null) {
      strokeWeight(15);
      thePoly.display(invCol(cols.get(voronoi.indexOf(thePoly))));
      strokeWeight(1);
    }
  }
  //long l2=endTimer();
  surface.setTitle("DelaunayTriangulation, frameRate= "+nf(frameRate, 2, 3));
}
void mouseMoved() {
  mx=mouseX;
  my=mouseY;
}
void displayPoint(PVector p, color col) {
  fill(col);
  noStroke();
  ellipse(p.x, p.y, 15, 15);
}