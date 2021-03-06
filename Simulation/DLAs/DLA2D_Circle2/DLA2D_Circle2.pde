ArrayList<PVector>stuck;
void setup(){
  size(1000,1000);
  pixelDensity(2);
  stuck=new ArrayList<PVector>();
  //stuck.add(new PVector(width/2,0));
}
float rad=5;
float fract(float f){
  float fract= f-floor(f);
  return cos(TWO_PI*fract)/2+0.5;
}
int iters=0;
void draw(){
  background(0);
  //println(frameRate);
  //for(int i=0;i<10;i++)
  doPoint();
  for(PVector p:stuck){
    //fill(255,0,0);
    colorMode(HSB,100);
    fill(color(fract(p.z*0.00001)*100,100,100));
    noStroke();
    ellipse(p.x,p.y,rad,rad);
  }
}
boolean notTouching(PVector p){
  for(PVector p1:stuck){
    if(dist(p.x,p.y,p1.x,p1.y)<rad)return false;
  }
  return true;
}
PVector createNewVector(){
  return new PVector(width/2,height/2);
}
float marg=-100;
void doPoint(){
  iters++;
  PVector p=createNewVector();
  while(notTouching(p)&&dist(p.x,p.y,width/2,height/2)<width/4+height/4){
    p.x+=random(-10,10);
    p.y+=random(-10,10);
  }
  p.z=iters;
  stuck.add(p);
}