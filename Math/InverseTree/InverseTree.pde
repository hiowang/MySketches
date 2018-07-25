PVector iterate1(PVector p){
  return new PVector(p.x/2,p.y/2);
}
PVector iterate2(PVector p){
  return new PVector(1/(p.x+1),p.y/(p.y+1));
}
PVector iterate3(PVector p){
  return new PVector(p.x/(p.x+1),1/(p.y+1));
}
void setup(){
  size(1000,1000);
  PVector p=new PVector(0,0);
  background(255);
  for(int i=0;i<10000000;i++){
    set(int(map(p.x,0,1,0,width)),int(map(p.y,0,1,0,height)),color(0));
    float r=random(3);
    if(r<1)p=iterate1(p);
    else if(r<2)p=iterate2(p);
    else p=iterate3(p);
  }
}