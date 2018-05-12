int[][]grid;
int gridSize, cellSize;
void settings() {
  gridSize=256;
  cellSize=1024/gridSize;
  size(gridSize*cellSize, gridSize*cellSize);
}
void setup() {
  grid=new int[gridSize][gridSize];
  for(int x=0;x<gridSize;x++){
    for(int y=0;y<gridSize;y++){
      grid[x][y]=int(random(numTypes));
      if(x==0||y==0||x==gridSize-1||y==gridSize-1)grid[x][y]=0;
    }
  }
}
int numTypes=16;
void draw() {
  background(255);
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      colorMode(HSB,100);
      fill(color(grid[x][y]*(100/numTypes),50,100));
      noStroke();
      colorMode(RGB,255);
      rect(x*cellSize,y*cellSize,cellSize,cellSize);
    }
  }
  iterate();
  surface.setTitle("CyclicCA, frameRate="+nf(frameRate,2,3));
}
void iterate(){
  int[][]newGrid=new int[gridSize][gridSize];
  for(int x=1;x<gridSize-1;x++){
    for(int y=1;y<gridSize-1;y++){
      int xmi=grid[x-1][y];
      int xpl=grid[x+1][y];
      int ymi=grid[x][y-1];
      int ypl=grid[x][y+1];
      int cur=grid[x][y];
      if(replaces(cur,xmi))cur=xmi;
      if(replaces(cur,xpl))cur=xpl;
      if(replaces(cur,ymi))cur=ymi;
      if(replaces(cur,ypl))cur=ypl;
      newGrid[x][y]=cur;
    }
  }
  for(int x=1;x<gridSize-1;x++){
    for(int y=1;y<gridSize-1;y++){
      grid[x][y]=newGrid[x][y];
    }
  }
}
boolean replaces(int b,int a){//does a replace b
  return a==((b+1)%numTypes);
  //if(a==1)return b==2;
  //if(a==2)return b==3;
  //if(a==3)return b==4;
  //if(a==4)return b==1;
  //return random(100)<100;
  //return false;
}