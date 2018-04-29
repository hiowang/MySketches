Grid grid;
//720/1280
float sizeX=1000;
float sizeY=1000;
float densX, densY;
MazeGenerator mazeGen;
void setup() {
  size(2000,2000);
  //size(750,750);
  doMaze(new MazeGeneratorBinaryTree(),"binary_tree");
  doMaze(new MazeGeneratorSidewinder(),"side_winder");
  //doMaze(new MazeGeneratorRecursiveBacktracker(),"recursive_backtracker");
  exit();
}
long start,end;
void startTiming(){
  start=System.currentTimeMillis();
}
long endTiming(){
  end=System.currentTimeMillis();
  return end-start;
}
void doMaze(MazeGenerator gen,String str){
  startTiming();
  initMaze(gen);
  int i=0;
  boolean isRecBack=str.equals("recursive_backtracker");
  float maxI=sizeX*sizeY;
  if(str.equals("recursive_backtracker"))maxI*=2;
  while(!mazeGen.isDone()){
    i++;
    if(i%100==0){
      println(nf(100.0*i/maxI,3,2));
      //long numOfMil=System.currentTimeMillis()-start;
      
      //float milPerUpdate=(float)numOfMil/i;
      //float remI=maxI-i;
      //float remTime=milPerUpdate*val;
      //float t=milPerUpdate*remI;
      //println(milPerUpdate);
      //println(nf(float(i)/maxI,3,4)+"%, "+nf(t,6,3)+"ms, "+nf(t/1000,4,3)+" secs, "+nf(t/1000/60,4,3)+" mins, "+nf(t/1000/50/50,2,20)+" hours, "+t);
    }
    mazeGen.update();
  }
  long time=endTiming();
  println("Maze gen time: "+time+"ms");
  startTiming();
  str="mazes/"+str+"/"+int(sizeX)+"x"+int(sizeY)+"/";
  
  background(0);
  PVector col=mazeGen.getColorScalar();
  grid.djikstraColoring(densX, densY,0, 0, col.x, col.y, col.z,150);
  save(str+"dijkstra.png");
  println(str+"dijkstra.png");
  
  background(0);
  grid.displayWalls(densX, densY, false, stroke, alpha);
  save(str+"grid.png");
  println(str+"grid.png");
  
  background(0);
  grid.djikstraColoring(densX, densY,0, 0, col.x, col.y, col.z,150);
  grid.displayWalls(densX, densY, false, stroke, alpha);
  save(str+"grid_dijkstra.png");
  println(str+"grid_dijkstra.png");
  time=endTiming();
  println("Image save time: "+time+"ms");
  
}
void initMaze(MazeGenerator gen){
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
  for(int x=0;x<2000;x++)
  //if(
    mazeGen.update();
  mazeGen.display();
  PVector col=mazeGen.getColorScalar();
  if(doD)grid.djikstraColoring(densX, densY,0, 0, col.x, col.y, col.z,150);
  strokeWeight(1);
  if(alpha!=0)grid.displayWalls(densX, densY, false, stroke, alpha);
}