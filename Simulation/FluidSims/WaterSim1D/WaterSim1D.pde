float[]u,v;

void setup(){
  size(1000,500);
  u=new float[width];
  v=new float[width];
  for(int x=0;x<width;x++){
    u[x]=100*cos(x*0.01);
    v[x]=0;
  }
}
void draw(){
  background(0);
  for(int x=0;x<width;x++){
    stroke(200,200,255);
    float f=getU(x)+250;
    line(x,height,x,height-f);
  }
  for(int i=0;i<5;i++)update();
}
float getU(int x){
  //if(x<0||x>=width)return 0;
  if(x<0)x=0;
  if(x>=width)x=width-1;
  return u[x];
}
float getV(int x){
  //if(x<0||x>=width)return 0;
  if(x<0)x=0;
  if(x>=width)x=width-1;
  return v[x];
}
void update(){
  float[]newU=new float[width];
  float[]newV=new float[width];
  for(int x=0;x<width;x++){
    newU[x]=u[x]+(mousePressed&&mouseX==x?100:0);
    newV[x]=v[x];
  }
  for(int x=0;x<width;x+=1){
    newV[x]+=(getU(x-1)+getU(x)+getU(x+1))/3-getU(x);
    newV[x]*=0.98;
    newU[x]+=newV[x]*2.1;
  }
  for(int x=0;x<width;x++){
    u[x]=newU[x];
    v[x]=newV[x];
  }
  
}