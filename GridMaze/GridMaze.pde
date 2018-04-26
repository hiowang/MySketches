Grid grid;
//720/1280
float sizeX=150;
float sizeY=150;
float densX, densY;
MazeGenerator mazeGen;
void setup() {
  //size(1000,1000);
  size(1000,1000);
  initMaze();
}
void initMaze() {
  densX=(width)/sizeX;
  densY=(height)/sizeY;
  mazeGen=new MazeGeneratorBinaryTree();
  mazeGen=new MazeGeneratorSidewinder();
  mazeGen=new MazeGeneratorRecursiveBacktracker();
  //mazeGen=new MazeGeneratorRecursiveDivider();
  grid=mazeGen.generateMaze(int(sizeX), int(sizeY));
}
void mousePressed() {
  initMaze();
}
boolean doD=true;
float alpha=255, stroke=255;
void keyPressed() {
  if(key=='d')doD=!doD;
  if (key=='l') {
    if (alpha==0) {
      alpha=255;
      stroke=255;
    } else {
      alpha=0;
      stroke=0;
    }
  }
  if(key=='s'){
    background(0);
    //mazeGen.display();
    
  PVector col=mazeGen.getColorScalar();
  grid.djikstraColoring(densX, densY, 0, 0, col.x, col.y, col.z,150);
  grid.displayWalls(densX, densY, false, stroke, alpha);
  save("maze.png");
  }
}
void draw() {
  background(0);
  //translate(50,50);
  //mx=int(sizeX/2);
  //my=int(sizeY/2);
  for(int x=0;x<200;x++)
    mazeGen.update();
  mazeGen.display();
  PVector col=mazeGen.getColorScalar();
  if(doD)grid.djikstraColoring(densX, densY,0, 0, col.x, col.y, col.z,150);
  strokeWeight(1);
  if(alpha!=0)grid.displayWalls(densX, densY, false, stroke, alpha);
}