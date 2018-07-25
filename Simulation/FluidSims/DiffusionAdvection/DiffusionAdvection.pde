float[][]grid;
float[][]vx;
float[][]vy;
int gridW, gridH;
void setup() {
  size(200, 200);
  gridW=width;
  gridH=height;
  grid=new float[gridW][gridH];
  vx=new float[gridW][gridH];
  vy=new float[gridW][gridH];
  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      grid[x][y]=0;
      //float ang=map(cos(x*0.05)+sin(y*0.05), -2, 2, 0, TWO_PI);
      float ang=TWO_PI*noise(x*0.03,y*0.03);
      vx[x][y]=cos(ang);
      vy[x][y]=sin(ang);
      //float m=sqrt(vx[x][y]*vx[x][y]+vy[x][y]*vy[x][y]);
      //vx[x][y]/=m;
      //vy[x][y]/=m;
    }
  }
  for (int i=0; i<100; i++) {
    grid[int(random(gridW-2)+1)][int(random(gridH-2)+1)]=1000;
  }
}
void draw() {
  background(255);
  if (mousePressed)
    grid[int(mouseX/(width/gridW))][int(mouseY/(height/gridH))]=1000;
  for (int x=0; x<grid.length; x++) {
    for (int y=0; y<grid[x].length; y++) {
      noStroke();
      fill(grid[x][y]*10);
      float w=width/grid.length;
      float h=height/grid[x].length;
      rect(x*w, y*h, w, h);
    }
  }
  int spacing=5;
  for (int x=0; x<gridW; x+=spacing) {
    for (int y=0; y<gridH; y+=spacing) {
      stroke(255, 0, 0);
      pushMatrix();
      translate((0.5+x)*width/gridW, (0.5+y)*height/gridH);
      //line(0, 0, vx[x][y]*spacing, vy[x][y]*spacing);
      popMatrix();
    }
  }
  for (int i=0; i<4; i++)iterate();
}
float dt=0.1;
void iterate() {
  diffuse();
  advect();
  vel_step();
}
float getDensity(int x, int y) {
  //if(x<0||y<0||x>=gridW||y>=gridH)return 0;
  if (x<0)x+=gridW;
  if (y<0)y+=gridH;
  if (x>=gridW)x-=gridW;
  if (y>=gridH)y-=gridH;
  return grid[x][y];
}
void diffuse() {
  float[][]newgrid=new float[grid.length][grid[0].length];
  for (int x=0; x<grid.length; x++)for (int y=0; y<grid[x].length; y++)newgrid[x][y]=grid[x][y];
  for (int x=0; x<grid.length; x++) {
    for (int y=0; y<grid[x].length; y++) {
      newgrid[x][y]=(getDensity(x, y) + dt*(getDensity(x-1, y)+getDensity(x+1, y)+getDensity(x, y-1)+getDensity(x, y+1)))/(1+4*dt);
    }
  }
  for (int x=0; x<grid.length; x++)for (int y=0; y<grid[x].length; y++)grid[x][y]=newgrid[x][y];
}
void advect() {
  float[][]newgrid=new float[grid.length][grid[0].length];
  for (int x=0; x<grid.length; x++)for (int y=0; y<grid[x].length; y++)newgrid[x][y]=grid[x][y];
  float dt0=dt;
  for (int i=1; i<grid.length-1; i++) {
    for (int j=1; j<grid[i].length-1; j++) {
      float x=i-dt0*vx[i][j];
      float y=j-dt0*vy[i][j];
      int i0=(int)x;
      int j0=(int)y;
      int i1=i0+1;
      int j1=j0+1;
      float s1=x-i0;
      float s0=1-s1;
      float t1=y-j0;
      float t0=1-t1;
      newgrid[i][j]=s0*(t0*grid[i0][j0]+t1*grid[i0][j1])+
                    s1*(t0*grid[i1][j0]+t1*grid[i1][j1]);
    }
  }
  for (int x=0; x<grid.length; x++)for (int y=0; y<grid[x].length; y++)grid[x][y]=newgrid[x][y];
}
void vel_step() {
}