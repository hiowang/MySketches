class Rect {
  PVector a, b, c, d;
  Rect(PVector a, PVector b, PVector c, PVector d) {
    this.a=a;
    this.b=b;
    this.c=c;
    this.d=d;
  }
  void display() {
    //stroke(255);
    //stroke(0);
    noStroke();
    //stroke(0,10);
    fill(255);
    beginShape();
    vertex(a.x, a.y, a.z);
    vertex(d.x, d.y, d.z);
    vertex(c.x, c.y, c.z);
    endShape(CLOSE);
    beginShape();
    vertex(a.x, a.y, a.z);
    vertex(b.x, b.y, b.z);
    vertex(d.x, d.y, d.z);
    endShape(CLOSE);
  }
}
void setup() {
  size(1000,1000, P3D);
  textFont(loadFont("Monospaced-20.vlw"));
  doInit();
}
void mousePressed() {
  doUpdate();
}
ArrayList<Rect>rects;
float rot=0;
boolean first=true;
float zoom=1;
void mouseWheel(MouseEvent me){
  float count=me.getCount();
  zoom+=count*0.01;
}
void draw() {
  background(100);
  rot+=0.0025;
  //eye is where the camera is
  float eyex=200*zoom;
  float eyey=-300*zoom;
  float eyez=0;
  //center is where the camera is looking
  float centerx=0;
  float centery=0;
  float centerz=0;
  //up is the up vector
  float upx=0;
  float upy=1;
  float upz=0;
  camera(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz);
  rotateY(rot);
  ambientLight(50,50,50);
  float lum=100;
  doPointLight(-worldSize,-400,-worldSize,lum);
  doPointLight( worldSize,-400,-worldSize,lum);
  doPointLight(-worldSize,-400, worldSize,lum);
  doPointLight( worldSize,-400, worldSize,lum);
  doDraw();
  pushMatrix();
  textAlign(LEFT,TOP);
  fill(255);
  stroke(255);
  text("Total difference: "+nfs(totalDiff,3,1),2,2);
  popMatrix();
}
void doPointLight(float x,float y,float z,float l){
  //pushMatrix();
  //translate(x,y,z);
  //fill(l);
  //noStroke();
  //stroke(l/2);
  //sphere(l/10);
  //translate(-x,-y,-z);
  //popMatrix();
  pointLight(l,l,l,x,y,z);
}
float worldSize=150;
void doInit() {
  rects=new ArrayList<Rect>();
  float r=worldSize;
  rects.add(new Rect(new PVector(-r, 0, -r), new PVector(-r, 0, r), new PVector(r, 0, -r), new PVector(r, 0, r)));
}
float getRand() {
  return random(-variance, variance/2);
}
float dv=0.8;
float variance=200;
float totalDiff=0;
void doUpdate() {
  totalDiff=0;
  ArrayList<Rect>newRects=new ArrayList<Rect>();
  for (Rect r : rects) {
    float rand=getRand();
    PVector a=r.a;
    PVector b=r.b;
    PVector c=r.c;
    PVector d=r.d;
    PVector ab=avg(a, b);
    PVector ac=avg(a, c);
    PVector ad=avg(a, d);
    //PVector bc=avg(b,c);
    PVector bd=avg(b, d);
    PVector cd=avg(c, d);
    if(first)rand=-abs(rand);
    ad.y+=rand;
    totalDiff+=rand;
    //ab.y+=rand/2;
    //bd.y+=rand/2;
    //cd.y+=rand/2;
    //ac.y+=rand/2;
    Rect r1=new Rect(a, ab, ac, ad);
    Rect r2=new Rect(ad, bd, cd, d);
    Rect r3=new Rect(ab, b, ad, bd);
    Rect r4=new Rect(ac, ad, c, cd);
    newRects.add(r1);
    newRects.add(r2);
    newRects.add(r3);
    newRects.add(r4);
  }
  rects=newRects;
  variance*=dv;
  dv*=0.8;
  first=false;
}
PVector avg(PVector a, PVector b) {
  return new PVector(a.x/2+b.x/2, a.y/2+b.y/2, a.z/2+b.z/2);
}
void doDraw() {

  for (Rect r : rects)r.display();
}