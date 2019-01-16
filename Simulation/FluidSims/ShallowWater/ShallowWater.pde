class Grid{
  float[][]arr;
  Grid(){
    arr=new float[gridW][gridH];
    for(int x=0;x<gridW;x++){
      for(int y=0;y<gridH;y++){
        arr[x][y]=0;
      }
    }
  }
  float get(float x,float y){
    int ix=int(x);
    int iy=int(y);
    if(ix<0)ix=gridW-1;
    if(iy<0)iy=gridH-1;
    if(ix>=gridW)ix=0;
    if(iy>=gridH)iy=0;
    return arr[ix][iy];
  }
  
  void set(float x,float y,float v){
    int ix=int(x);
    int iy=int(y);
    if(ix<0)ix=gridW-1;
    if(iy<0)iy=gridH-1;
    if(ix>=gridW)ix=0;
    if(iy>=gridH)iy=0;
    arr[ix][iy]=v;
  }
  
  Grid clone(){
    Grid g=new Grid();
    for(int x=0;x<gridW;x++){
      for(int y=0;y<gridH;y++){
        g.arr[x][y]=arr[x][y];
      }
    }
    return g;
  }
}

int gridW=150;
int gridH=150;
int tileW=7;
int tileH=7;
void settings(){
  size(gridW*tileW,gridH*tileH,P3D);
}

//velx=u
//vely=w
//depth=d
//
Grid u,w,d;
float dt=0.001;
float gravity=60;

Grid advect(Grid velX,Grid velY,Grid d){
  Grid g=new Grid();
  for(int i=0;i<gridW;i++){
    for(int j=0;j<gridH;j++){
      float x=i-dt*velX.get(i,j);
      float y=j-dt*velY.get(i,j);
      int i0=(int)x;
      int j0=(int)y;
      int i1=i0+1;
      int j1=j0+1;
      float s1=x-i0;
      float s0=1-s1;
      float t1=y-j0;
      float t0=1-t1;
      g.set(i,j,s0*(t0*d.get(i0,j0)+t1*d.get(i0,j1))+
        s1*(t0*d.get(i1,j0)+t1*d.get(i1,j1)));
      
    }
  }
  return g;
}

void setup(){
  u=new Grid();
  w=new Grid();
  d=new Grid();
  
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      //boundary conditions are broken
      d.arr[x][y]=5+cos( float(x)/gridW*y/gridH*TWO_PI  );
    }
  }
  
}


void update(){
  Grid uA=advect(u,w,u);
  Grid wA=advect(u,w,w);
  Grid dA=advect(u,w,d);
  
  Grid hA=d.clone();
  
  Grid nextU=uA.clone();
  Grid nextW=wA.clone();
  
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      nextU.arr[x][y]-=dt*gravity*(hA.get(x+1,y)-hA.get(x,y))/2;
      nextW.arr[x][y]-=dt*gravity*(hA.get(x,y+1)-hA.get(x,y))/2;
    }
  }
  
  Grid nextD=dA.clone();
  
  for(int i=0;i<gridW;i++){
    for(int j=0;j<gridH;j++){
      float divX=(nextU.get(i+1,j)-nextU.get(i-1,j))/2.0;
      float divY=(nextW.get(i,j+1)-nextW.get(i,j-1))/2.0;
      nextD.arr[i][j]-=dt*dA.get(i,j)*(divX+divY);
    }
  }
  
  u=nextU.clone();
  w=nextW.clone();
  d=nextD.clone();
  
}

void mouseDragged(){
  int r=5;
  float f=1.5;
  int mx=int(mouseX/tileW);
  int my=int(mouseY/tileH);
  for(int x=-r;x<=r;x++){
    for(int y=-r;y<=r;y++){
      int i=x+mx;
      int j=y+my;
      if(i<0||j<0||i>=gridW||j>=gridH)continue;
      u.arr[i][j]+=f*(mouseX-pmouseX);
      w.arr[i][j]+=f*(mouseY-pmouseY);
      d.arr[i][j]+=0.1;
    }
  }
}

void draw(){
  for(int i=0;i<5;i++)update();
  background(0);
  float totalDens=0;
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      totalDens+=d.get(x,y);
      fill(20*d.get(x,y));
      noStroke();
      rect(x*tileW,y*tileH,tileW,tileH);
      
      //if((x+y)%2==0){
      //  stroke(255,0,0);
      //  line((0.5+x)*tileW,(0.5+y)*tileH,(0.5+x)*tileW+2*u.get(x,y),(0.5+y)*tileH+2*w.get(x,y));
      //}
    }
  }
  println(totalDens);
  //background(255);
  //camera(0,50,gridH, gridW,0,0, 0,-1,0);
  
  //stroke(0);
  //fill(255/2);
  
  //pointLight(255,255,255,  0,100,0);
  
  //for(int x=0;x<gridW;x++){
  //  for(int y=0;y<gridH;y++){
  //    pushMatrix();
  //    translate(x,d.get(x,y)/2,y);
  //    box(1,d.get(x,y),1);
  //    popMatrix();
  //  }
  //}
  
}