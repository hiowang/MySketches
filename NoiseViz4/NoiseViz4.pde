class Particle {
  PVector pos;
  Particle() {
    pos=new PVector(random(width), random(height));
    newPos=pos;
  }
  PVector newPos;
  void display() {
    newPos=pos;
    set((int)pos.x, (int)pos.y, color(0));
    float here=perlin(pos.x, pos.y);
    float xmi=perlin(pos.x-1, pos.y)-here;
    float xpl=perlin(pos.x+1, pos.y)-here;
    float ymi=perlin(pos.x,pos.y-1)-here;
    float ypl=perlin(pos.x,pos.y+1)-here;
    float minx=min(xmi,xpl);
    float miny=min(ymi,ypl);
    if(minx==xmi)newPos.x--;
    if(minx==xpl)newPos.x++;
    if(miny==ymi)newPos.y--;
    if(miny==ypl)newPos.y++;
  }
  void collide(Particle other){
    //newPos.x+=random(-1,1);
    //newPos.y+=random(-1,1);
    //other.newPos.x+=random(-5,5);
    //other.newPos.y+=random(-5,5);
  }
}
float perlin(float x, float y) {
  return noise(noiseZoom*x, noiseZoom*y,frameCount*noiseChange);
}
float noiseChange=0.0;
float noiseZoom=0.01;
ArrayList<Particle>particles;
void setup() {
  size(500,500);
  //size(750,750);
  //fullScreen();
  //pixelDensity(2);
  //width*=2;
  //height*=2;
  particles=new ArrayList<Particle>();
  for (int i=0; i<5000; i++) {
    particles.add(new Particle());
  }
  background(255);
}
void draw() {
  if (mousePressed) {
    Particle p=new Particle();
    p.pos.x=mouseX;
    p.pos.y=mouseY;
    particles.add(p);
  }
  //fill(255, 5);
  //rect(0, 0, width, height);
  for (Particle p : particles) {
    p.display();
    for(Particle p1:particles){
      if(p.pos==p1.pos){
        p.collide(p1);
      }
    }
  }
  for(Particle p:particles){
    p.pos=p.newPos;
    if(p.pos.x<0)p.pos.x=width;
    if(p.pos.y<0)p.pos.y=height;
    if(p.pos.x>width)p.pos.x=0;
    if(p.pos.y>height)p.pos.y=0;
  }
}