Grid grid;
//720/1280
float sizeX=5;
float sizeY=5;
float densX, densY;
MazeGenerator mazeGen;
void setup() {
  size(4000, 4000);
  noSmooth();
  //size(750,750);
  //mazeGen=new MazeGeneratorBinaryTree();
  //mazeGen=new MazeGeneratorSidewinder();
  //mazeGen=new MazeGeneratorRecursiveBacktracker();
  //initMaze(mazeGen);
  //iterateMaze("");

  //doAlgs();
  //sizeX=sizeY=5;
  //doAlgs();
  //sizeX=sizeY=10;
  //doAlgs();
  //sizeX=sizeY=50;
  //doAlgs();
  //sizeX=sizeY=100;
  //doAlgs();
  //sizeX=sizeY=200;
  //doAlgs();
  //sizeX=sizeY=500;
  //doAlgs();
  //sizeX=sizeY=1000;
  //doAlgs();
  exit();
}
void doAlgs() {  
  doMaze(new MazeGeneratorBinaryTree(), "binary_tree");
  doMaze(new MazeGeneratorSidewinder(), "side_winder");
  doMaze(new MazeGeneratorRecursiveBacktracker(), "recursive_backtracker");
}
long start, end;
void startTiming() {
  start=System.currentTimeMillis();
}
long endTiming() {
  end=System.currentTimeMillis();
  return end-start;
}
void doConnections() {
  PVector a=mazeGen.getColorScalar();
  grid.connectionColoring(a.x, a.y, a.z, 255);
  //grid.displayWalls(densX, densY, false, stroke, 0);
}
void doJikstra() {
  background(0);
  PVector col=mazeGen.getColorScalar();
  grid.djikstraColoring(densX, densY, int(sizeX/2),int(sizeY/2), col.x, col.y, col.z, 150);
}
void doGrid() {
  background(0);
  grid.displayWalls(densX, densY, false, stroke, alpha);
}
void doGridJikstra() {
  background(0);
  PVector col=mazeGen.getColorScalar();
  grid.djikstraColoring(densX, densY, 0, 0, col.x, col.y, col.z, 150);
  grid.displayWalls(densX, densY, false, stroke, alpha);
}
void iterateMaze(String str) {
  int i=0;
  boolean isRecBack=str.equals("recursive_backtracker");
  float maxI=sizeX*sizeY;
  if (str.equals("recursive_backtracker"))maxI*=2;
  while (!mazeGen.isDone()) {
    i++;
    if (i%100==0) {
      println(nf(100.0*i/maxI, 3, 2)+" "+(System.currentTimeMillis()-start));
      //float val=float(i)/maxI;

      //long numOfMil=System.currentTimeMillis()-start;
      //float milPerI=numOfMil/float(i);
      //milPerI*=maxI-i;
      //println(milPerI);

      //float milPerUpdate=(float)numOfMil/i;
      //float remI=maxI-i;
      //float remTime=milPerUpdate*val;
      //float t=milPerUpdate*remI;
      //println(milPerUpdate);
      //println(nf(float(i)/maxI,3,4)+"%, "+nf(t,6,3)+"ms, "+nf(t/1000,4,3)+" secs, "+nf(t/1000/60,4,3)+" mins, "+nf(t/1000/50/50,2,20)+" hours, "+t);
    }
    mazeGen.update();
  }
}
void doMaze(MazeGenerator gen, String str) {
  startTiming();
  initMaze(gen);
  iterateMaze(str);
  long time=endTiming();
  println("Maze gen time: "+time+"ms");
  startTiming();
  str="mazes/"+str+"/"+int(sizeX)+"x"+int(sizeY)+"/";

  doJikstra();
  save(str+"dijkstra.png");
  println(str+"dijkstra.png");

  doGrid();
  save(str+"grid.png");
  println(str+"grid.png");

  doGridJikstra();
  save(str+"grid_dijkstra.png");
  println(str+"grid_dijkstra.png");

  doConnections();
  save(str+"connections.png");
  println(str+"connections.png");
  time=endTiming();
  println("Image save time: "+time+"ms");
}
void initMaze(MazeGenerator gen) {
  densX=(width)/sizeX;
  densY=(height)/sizeY;
  mazeGen=gen;
  grid=mazeGen.generateMaze(int(sizeX), int(sizeY));
  mazeGen.display();
  //PVector col=mazeGen.getColorScalar();
  //grid.djikstraColoring(densX, densY,0, 0, col.x, col.y, col.z,150);
  //grid.displayWalls(densX, densY, false, stroke, 255);
}
void initMaze() {
  densX=(width)/sizeX;
  densY=(height)/sizeY;
  mazeGen=new MazeGeneratorBinaryTree();
  mazeGen=new MazeGeneratorSidewinder();
  mazeGen=new MazeGeneratorRecursiveBacktracker();
  grid=mazeGen.generateMaze(int(sizeX), int(sizeY));
}
void mousePressed() {
  initMaze();
}
boolean doD=true;
float alpha=255, stroke=255;
void keyPressed() {
  if (key=='d')doD=!doD;
  if (key=='l') {
    if (alpha==0) {
      alpha=255;
      stroke=255;
    } else {
      alpha=0;
      stroke=0;
    }
  }
  if (key=='s') {
    background(0);
    //mazeGen.display();

    PVector col=mazeGen.getColorScalar();
    grid.djikstraColoring(densX, densY, 0, 0, col.x, col.y, col.z, 150);
    grid.displayWalls(densX, densY, false, stroke, alpha);
    save("maze.png");
  }
}
void draw() {
  //background(0);
  //translate(50,50);
  //mx=int(sizeX/2);
  //my=int(sizeY/2);
  //for (int x=0; x<2000; x++)
  //if(
  //mazeGen.update();
  //mazeGen.display();
  //PVector col=mazeGen.getColorScalar();
  //if (doD)grid.djikstraColoring(densX, densY, 0, 0, col.x, col.y, col.z, 150);
  //strokeWeight(1);
  //if (alpha!=0)grid.displayWalls(densX, densY, false, stroke, alpha);
}