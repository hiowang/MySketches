void setup(){
  size(500,500);
  particles=new ArrayList<Particle>();
}
void mouseDragged(){
  if(frameCount%5==0){
    Particle p=new Particle();
    p.x=new PVector(mouseX,mouseY);
    particles.add(p);
  }
}
ArrayList<Particle>particles;
void draw(){
  background(0);
  for(Particle p:particles){
    //fill(p.p*100);
    noStroke();
    ellipse(p.x.x,p.x.y,H,H);
  }
  for(int i=0;i<300;i++)stepSim();
}
  