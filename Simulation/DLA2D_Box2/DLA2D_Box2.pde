ArrayList<PVector>stuck;
void setup(){
  size(500,500);
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
  for(int i=0;i<10;i++)doPoint();
  for(PVector p:stuck){
    //fill(255,0,0);
    colorMode(HSB,100);
    fill(color(fract(p.z*0.000025)*100,100,100));
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
  while(notTouching(p)&&p.x>0&&p.y>0&&p.x<width&&p.y<height){
    p.x+=random(-5,5);
    p.y+=random(-5,5);
  }
  p.z=iters;
  stuck.add(p);
}