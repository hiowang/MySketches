int gridSize,cellSize;
color[][]grid;
void settings(){
  gridSize=16;
  cellSize=1024/gridSize;
  size(gridSize*cellSize,gridSize*cellSize);
}
void setup(){
  grid=new color[gridSize][gridSize];
  for(int x=0;x<gridSize;x++){
    for(int y=0;y<gridSize;y++){
      grid[x][y]=color(0);
      //grid[x][y]=color(random(255),random(255),random(255));
    }
  }
  for(int i=0;i<3;i++){
    grid[int(random(gridSize))][int(random(gridSize))]=color(random(255),random(255),random(255));
  }
}
void draw(){
  background(255);
  for(int x=0;x<gridSize;x++){
    for(int y=0;y<gridSize;y++){
      fill(grid[x][y]);
      noStroke();
      rect(x*cellSize,y*cellSize,cellSize,cellSize);
    }
  }
  iterate();
  //saveFrame("frames/frame-####.png");
  surface.setTitle("SteppingStoneCA, frameRate="+nf(frameRate,2,3));
}
void iterate(){
  color[][]newGrid=new color[gridSize][gridSize];
  for(int x=0;x<gridSize;x++){
    for(int y=0;y<gridSize;y++){
      newGrid[x][y]=grid[x][y];
    }
  }
  for(int x=0;x<gridSize;x++){
    for(int y=0;y<gridSize;y++){
      if(random(100)<90)continue;
      ArrayList<Integer>cols=new ArrayList<Integer>();
      if(x>0)cols.add(grid[x-1][y]);
      if(y>0)cols.add(grid[x][y-1]);
      if(x<gridSize-1)cols.add(grid[x+1][y]);
      if(y<gridSize-1)cols.add(grid[x][y+1]);
      while(cols.contains(color(0)))cols.remove((Integer)color(0));
      if(cols.size()==0)continue;
      newGrid[x][y]=cols.get(int(random(cols.size())));
    }
  }
  for(int x=0;x<gridSize;x++){
    for(int y=0;y<gridSize;y++){
      grid[x][y]=newGrid[x][y];
    }
  }
}