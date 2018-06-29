class Particle{
  PVector x,v,f;
  float rho,p;
  Particle(){
    x=new PVector(random(width),random(height));
    v=new PVector(0,0);
    f=new PVector(0,0);
    rho=0;
    p=0;
  }
}