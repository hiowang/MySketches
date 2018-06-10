ArrayList<PVector>points;
ArrayList<Integer>cols;
PImage img;
void settings() {
  float f=1;
  size(int(1008*f), int(756*f),P3D);
}
boolean saveImgs=false;
void setup() {
  //fullScreen();
  //size(150,150);
  pixelDensity(2);
  points=new ArrayList<PVector>();
  cols=new ArrayList<Integer>();
  tris=new ArrayList<Tri>();
  img=loadImage("Zoe2.jpg");
  println("Loaded image");
  float m=150;
  addPoint(-m,-m);
  addPoint(-m,height+m);
  addPoint(width+m,-m);
  addPoint(width+m,height+m);
  //for(int i=0;i<2000;i++)addPoint(random(width),random(height));
  println("Added points");
  tris=triangulate(points);
  println("Triangulated points");
  drawn=false;
}
void addPoint(float x, float y) {
  points.add(new PVector(x, y));
  //cols.add(color(random(255),random(255),random(255)));
  cols.add(img.get(int(map(x, 0, width, 0, img.width)), int(map(y, 0, height, 0, img.height))));
}
ArrayList<Tri>tris;
void mousePressed() {
  //if(frameCount%5!=0)return;
  //points.add(new PVector(mouseX, mouseY));
  addPoint(mouseX, mouseY);
  //for(int i=0;i<100;i++)addPoint(random(width),random(height));
  tris=triangulate(points);
  drawn=false;
  //delaunayPoint(points.get(points.size()-1));
  remBads();
}
//barycentric interpolation for images/colors
boolean drawn=false;
void draw() {
  //if (drawn)return;
  //drawn=true;
  background(255);
  println("Start draw");


  drawInterpolation();
  if (saveImgs) {
    save(points.size()+"-interp.png");
    println("interp.png");
  }
  //drawOutlines();
  if (saveImgs) {
    save(points.size()+"-interp-outlines.png");
    println("interp-outlines.png");
  }

  //background(255);
  //drawFlat();
  if (saveImgs) {
    save(points.size()+"-flat.png");
    println("flat.png");
  }
  //drawOutlines();
  if (saveImgs) {
    save(points.size()+"-flat-outlines.png");
    println("flat-outlines.png");
  }

  println("End draw");
}