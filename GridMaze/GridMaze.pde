Grid grid;
int sizeX=25;
int sizeY=25;
int densX,densY;
void setup(){
  size(600,600);
  initMaze();
}
void initMaze(){
  grid=new Grid(sizeX,sizeY);
  densX=(width-100)/sizeX;
  densY=(height-100)/sizeY;
  for(int i=0;i<grid.w;i++){
    for(int j=0;j<grid.h;j++){
      ArrayList<Dir>dirs=new ArrayList<Dir>();
      //dirs.add(Dir.XPL);
      //dirs.add(Dir.YPL);
      if(i<grid.w-1)dirs.add(Dir.XPL);
      if(j<grid.h-1)dirs.add(Dir.YPL);
      if(dirs.size()==0)continue;
      grid.setWall(i,j,dirs.get(int(random(dirs.size()))),true);
    }
  }
}
void mousePressed(){
  initMaze();
}
void draw(){
  background(0);
  translate(50,50);
  int mx=constrain(int(map(mouseX,0,width,0,sizeX)),0,sizeX-1);
  int my=constrain(int(map(mouseY,0,height,0,sizeY)),0,sizeY-1);
  grid.djikstraColoring(densX,mx,my,0.5,1,0.5);
  grid.displayWalls(densY,false);
}