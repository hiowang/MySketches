int[][]grid;
int gridSize=200;
int cellSize=5;
void settings() {
  size(gridSize*cellSize, gridSize*cellSize);
}
color[]cols;
void setup() {
  grid=new int[gridSize][gridSize];
  grid[gridSize/2][gridSize/2]=300000;
  cols=new color[4];
  for (int x=0; x<4; x++) {
    colorMode(HSB, 100);
    cols[x]=color(random(100), 50, 100);
    colorMode(RGB, 255);
  }
}
void draw() {
  background(255);
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      int i=grid[x][y];
      fill(cols[ i<0?0:(i>=4?3:i)] );
      stroke(255, 30);
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  for(int i=0;i<10;i++)iterate();
}
void iterate() {
  int[][]newGrid=new int[gridSize][gridSize];
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      newGrid[x][y]=grid[x][y];
    }
  }
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      if (grid[x][y]>=4) {
        if (x>0) {
          newGrid[x][y]--;
          newGrid[x-1][y]++;
        }
        if (y>0) {
          newGrid[x][y]--;
          newGrid[x][y-1]++;
        }
        if (x<gridSize-1) {
          newGrid[x][y]--;
          newGrid[x+1][y]++;
        }
        if (y<gridSize-1) {
          newGrid[x][y]--;
          newGrid[x][y+1]++;
        }
      }
    }
  }
  //for (int x=0; x<gridSize; x++) {
  //for (int y=0; y<gridSize; y++) {
  //grid[x][y]=newGrid[x][y];
  //}
  //}
  grid=newGrid;
}