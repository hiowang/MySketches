int[][]grid;
int gridSize, cellSize;
void settings() {
  gridSize=200;
  cellSize=1024/gridSize;
  size(gridSize*cellSize, gridSize*cellSize);
}
void setup() {
  grid=new int[gridSize][gridSize];
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      grid[x][y]=int(random(numTypes));
      //if (x==0||y==0||x==gridSize-1||y==gridSize-1)grid[x][y]=0;
    }
  }
}
int numTypes=15;
void draw() {
  background(255);
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      colorMode(HSB, 100);
      fill(color(grid[x][y]*(100/numTypes), 50, 100));
      //fill(color(grid[x][y]*100/numTypes));
      noStroke();
      colorMode(RGB, 255);
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  //for (int i=0; i<100; i++)
    iterate();
  surface.setTitle("CyclicCA2D, frameRate="+nf(frameRate, 2, 3));
}
void iterate() {
  int[][]newGrid=new int[gridSize][gridSize];
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      ArrayList<Integer>ints=new ArrayList<Integer>();
      if (x>0)ints.add(grid[x-1][y]);
      if (y>0)ints.add(grid[x][y-1]);
      if (x<gridSize-1)ints.add(grid[x+1][y]);
      if (y<gridSize-1)ints.add(grid[x][y+1]);
      int cur=grid[x][y];
      for (Integer i : ints) {
        if (replaces(cur, i)) {
          cur=i;
          break;
        }
      }
      newGrid[x][y]=cur;
    }
  }
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      grid[x][y]=newGrid[x][y];
    }
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