
Tri tri;
void setup() {
  //size(500, 500);
  size(1000,1000);
  tri=new Tri();
  tri.a=new PVector(250,500);//rand w,rand h
  tri.b=new PVector(750,500);
  //tri.c=new PVector(width/2,height/2+300);
  pixelDensity(2);
}
void draw() {
  background(255);
  noFill();
  tri.c=new PVector(mouseX,mouseY);
  //float t=frameCount*0.01;
  triDraw(tri);
  PVector circumcenter=circumCenter(tri);
  float circumrad=circumRad(tri,circumcenter);
  //tri.c=new PVector(cos(t)*circumrad+width/2,sin(t)*circumrad+height/2);
  ellipse(circumcenter.x,circumcenter.y,10,10);
  ellipse(circumcenter.x,circumcenter.y,circumrad*2,circumrad*2);
  ellipse(tri.a.x,tri.a.y,5,5);
  ellipse(tri.b.x,tri.b.y,5,5);
  ellipse(tri.c.x,tri.c.y,5,5);
  lineDraw(new Line(tri.pointAB(),circumcenter));
  lineDraw(new Line(tri.pointBC(),circumcenter));
  lineDraw(new Line(tri.pointAC(),circumcenter));
}