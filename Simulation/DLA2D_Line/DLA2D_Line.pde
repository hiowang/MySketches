ArrayList<PVector>stuck;
void setup(){
  size(500,500);
  stuck=new ArrayList<PVector>();
  //stuck.add(new PVector(width/2,0));
}
float rad=3;
float fract(float f){
  float fract= f-floor(f);
  return cos(TWO_PI*fract)/2+0.5;
}
float highestY;
int iters=0;
void draw(){
  background(0);
  highestY=0;
  for(PVector p:stuck)if(p.y<highestY)highestY=p.y;
  for(int i=0;i<10;i++)doPoint();
  for(PVector p:stuck){
    //fill(255,0,0);
    colorMode(HSB,100);
    fill(color(fract(p.z*0.00005)*100,100,100));
    noStroke();
    ellipse(p.x,p.y,rad,rad);
  }
}
boolean notTouching(PVector p){
  for(PVector p1:stuck){
    //if(p1.y>highestY+200)continue;
    if(dist(p.x,p.y,p1.x,p1.y)<rad)return false;
  }
  return true;
}
void doPoint(){
  iters++;
  PVector p=new PVector(random(0,width-0),0,iters);
  p.x=width/2+random(-100,100);
  p.x=random(width);
  while(p.y<height&&notTouching(p)){
    p.x+=random(-5,5);
    p.y+=1;
    if(p.x<0)p.x=width;
    if(p.x>width)p.x=0;
  }
  if(p.y>highestY)stuck.add(p);
}