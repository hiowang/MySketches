void carpet(float x,float y,float w,float h,int n){
  if(n>7)return;
  fill(255);
  noStroke();
  float nw=w/3;
  float nh=h/3;
  rect(x+nw,y+nh,nw,nh);
  if(corners)carpet(x,y,nw,nh,n+1);
  if(edges)carpet(x+nw,y,nw,nh,n+1);
  if(corners)carpet(x+2*nw,y,nw,nh,n+1);
  if(edges)carpet(x,y+nh,nw,nh,n+1);
  if(corners)carpet(x,y+2*nh,nw,nh,n+1);
  if(edges)carpet(x+nw,y+2*nh,nw,nh,n+1);
  if(edges)carpet(x+2*nw,y+nh,nw,nh,n+1);
  if(corners)carpet(x+2*nw,y+2*nh,nw,nh,n+1);
  //rect(x+w/3,y+h/3,w/3,h/3);
}
boolean edges=true;
boolean corners=true;
void setup(){
  size(5000,5000);
  background(#3B117D);
  carpet(0,0,width,height,1);
  save("frame.png");
  exit();
}