ArrayList<Particle>particles;

void setup() {
  size(750, 750);
  particles=new ArrayList<Particle>();
  float marg=400;
  for (int i=0; i<40; i++) {
    particles.add(new Particle(new PVector(random(-marg,marg),random(-marg,marg))));
  }
}
float scale=1;
void mouseDragged(){
  particles.add(new Particle(new PVector(map(mouseX,0,width,-width*scale,width*scale),map(mouseY,0,height,-height*scale,height*scale))));
}
void mouseWheel(MouseEvent e){
  float v=e.getCount();
  scale+=v/10;
  if(scale<0.1)scale=0.1;
}
void draw() {
  background(255);

  float d=5;
  for (int x=0; x<width; x+=d) {
    for (int y=0; y<height; y+=d) {
      float dens=0;
      float mapx=map(x,0,width,-width*scale,width*scale);
      float mapy=map(y,0,height,-height*scale,height*scale);
      for (Particle p : particles) {
        float a=dist(mapx, mapy, p.pos.x, p.pos.y);
        if (a>20)continue;
        //dens+=450-a*3;
        dens+=(20-a)*10;
      }
      fill(0,0,dens/5);
      //println(dens/10);
      noStroke();
      rect(x, y, d, d);
    }
  }
  surface.setTitle("FluidSim_2D_V1, framerate: "+nf(frameRate,2,1));
  for (Particle p : particles)p.update(true);
  //for (Particle p : particles)p.display();
}