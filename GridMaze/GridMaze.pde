Grid grid;
float sizeX=100;
float sizeY=100;
float densX, densY;
MazeGenerator mazeGen;
void setup() {
  size(600, 600);
  initMaze();
}
void initMaze() {
  densX=(width)/sizeX;
  densY=(height)/sizeY;
  //mazeGen=new MazeGeneratorBinaryTree();
  mazeGen=new MazeGeneratorSidewinder();
  //mazeGen=new MazeGeneratorRecursiveBacktracker();
  grid=mazeGen.generateMaze(int(sizeX), int(sizeY));
}
void mousePressed() {
  initMaze();
}
float alpha=255, stroke=255;
void keyPressed() {
  if (key=='l') {
    if (alpha==0) {
      alpha=255;
      stroke=255;
    } else {
      alpha=0;
      stroke=0;
    }
  }
}
void draw() {
  background(0);
  //translate(50,50);
  int mx;
  int my;
  mx=0;
  my=0;
  //mx=int(sizeX/2);
  //my=int(sizeY/2);
  for(int x=0;x<100;x++)mazeGen.update();
  PVector col=mazeGen.getColorScalar();
  grid.djikstraColoring(densX, densY, mx, my, col.x, col.y, col.z);
  strokeWeight(2);
  grid.displayWalls(densX, densY, false, stroke, alpha);
}