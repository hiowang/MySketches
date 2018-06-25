int[][]grid;
int gridSize, cellSize;
void settings() {
  gridSize=256;
  cellSize=1024/gridSize;
  size(gridSize*cellSize, gridSize*cellSize);
}
void setup() {
  grid=new int[gridSize][gridSize];
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      grid[x][y]=-1;
      if(y==0)grid[x][y]=int(random(numTypes));
      //if (x==0||y==0||x==gridSize-1||y==gridSize-1)grid[x][y]=0;
    }
  }
}
int numTypes=4;
void draw() {
  background(255);
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      colorMode(HSB, 100);
      fill((grid[x][y]==-1?color(0):color(grid[x][y]*(100/numTypes), 50, 100)));
      noStroke();
      colorMode(RGB, 255);
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  iterate();
  surface.setTitle("CyclicCA1D, frameRate="+nf(frameRate, 2, 3));
}
int genNum=0;
void iterate() {
  if (genNum>=gridSize-1){
    //return;
    genNum--;
    for(int y=1;y<gridSize;y++){
      for(int x=0;x<gridSize;x++){
        grid[x][y-1]=grid[x][y];
      }
    }
  }
  genNum++;
  for (int x=0; x<gridSize; x++) {
    ArrayList<Integer>ints=new ArrayList<Integer>();
    if (x>0)ints.add(grid[x-1][genNum-1]);
    if (x<gridSize-1)ints.add(grid[x+1][genNum-1]);
    int cur=grid[x][genNum-1];
    for (Integer i : ints) {
      if (replaces(cur, i)) {
        cur=i;
        break;
      }
    }
    grid[x][genNum]=cur;
  }
}
boolean replaces(int b, int a) {//does a replace b
  return a==((b+1)%numTypes);
  //if(a==1)return b==2;
  //if(a==2)return b==3;
  //if(a==3)return b==4;
  //if(a==4)return b==1;
  //return random(100)<100;
  //return false;
}