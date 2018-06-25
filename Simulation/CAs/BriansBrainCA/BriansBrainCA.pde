int[][]grid;
int gridw=300;
int gridh=300;
void setup() {
  size(600, 600);
  grid=new int[gridw][gridh];
  for (int x=0; x<gridw; x++) {
    for (int y=0; y<gridh; y++) {
      grid[x][y]=random(100)<50?ON:OFF;
    }
  }
}
int OFF=0;
int DYING=1;
int ON=2;
void draw() {
  background(255);
  for (int x=0; x<gridw; x++) {
    for (int y=0; y<gridh; y++) {
      int i=grid[x][y];
      if (i==OFF)fill(0);
      if (i==DYING)fill(255/2);
      if (i==ON)fill(255);
      noStroke();
      rect(x*width/gridw, y*height/gridw, width/gridw, height/gridh);
    }
  }
  update();
}
int cell(int x, int y) {
  while (x<0)x+=gridw;
  while (y<0)y+=gridh;
  while (x>=gridw)x-=gridw;
  while (y>=gridh)y-=gridh;
  return grid[x][y];
}
void update() {
  int[][]newgrid=new int[gridw][gridh];
  for (int x=0; x<gridw; x++) {
    for (int y=0; y<gridh; y++) {
      if (grid[x][y]==DYING)newgrid[x][y]=OFF;
      else if (grid[x][y]==OFF) {
        int n=0;
        if(cell(x-1,y)==ON)n++;
        if(cell(x+1,y)==ON)n++;
        if(cell(x,y-1)==ON)n++;
        if(cell(x,y+1)==ON)n++;
        if(cell(x-1,y-1)==ON)n++;
        if(cell(x-1,y+1)==ON)n++;
        if(cell(x+1,y-1)==ON)n++;
        if(cell(x+1,y+1)==ON)n++;
        if(n==2)newgrid[x][y]=ON;
        else newgrid[x][y]=OFF;
      } else if (grid[x][y]==ON) {
        newgrid[x][y]=DYING;
      }
    }
  }
  grid=newgrid;
}