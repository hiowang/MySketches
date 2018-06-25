float[][]cur;
int dens=4;
int gridSize=256;
int windowSize;
boolean do3D=false;
void settings(){
  windowSize=gridSize*dens;
  if(do3D)size(windowSize,windowSize,P3D);
  else size(windowSize,windowSize,P2D);
}
void setup(){
  cur=new float[gridSize][gridSize];
}
void draw(){
  background(255);
  if(do3D){
  }else{
    for(int x=0;x<gridSize;x++){
      for(int y=0;y<gridSize;y++){
        fill(cur[x][y]);
        noStroke();
        rect(x*dens,y*dens,dens,dens);
      }
    }
  }
  update();
  surface.setTitle("WaterSim, frameRate="+nf(frameRate,2,3));
}
void mouseMoved(){
  cur[mouseX/dens][mouseY/dens]=2000;
}

float val(int x,int y){
  if(x<0||y<0||x>=gridSize||y>=gridSize)return 0;
  return cur[x][y];
}

void update(){
  float[][] next=new float[gridSize][gridSize];
  for(int x=0;x<gridSize;x++){
    for(int y=0;y<gridSize;y++){
      next[x][y]=(val(x-1,y)+val(x+1,y)+val(x,y-1)+val(x,y+1))/4;
      next[x][y]*=1;
    }
  }
  for(int x=0;x<gridSize;x++){
    for(int y=0;y<gridSize;y++){
      cur[x][y]=next[x][y];
    }
  }
  //cur=next;
}