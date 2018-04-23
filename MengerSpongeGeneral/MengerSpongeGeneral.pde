
void setup() {
  size(750, 750, P3D);
  perspective(PI/3.0, (float) width/height, 1, 1000000);
  boxes=new ArrayList<Box>();
  float ss=125;
  boxes.add(new Box(-ss/2, -ss/2, -ss/2, ss));
  initGrids();
  grid=gridMengerSponge;
  grid=gridMengerSpiky;
  grid=gridMengerSnowflake;
  grid=gridRemEdges;
  grid=gridRemCorners;
  grid=gridLeaveEdges;
}
void mousePressed() {
  iterate();
}
boolean[][][]grid;
boolean[][][] gridMengerSpiky=newGrid(false);        //-corners-edges
boolean[][][] gridMengerSnowflake=newGrid(false);    //        -edges-centers
boolean[][][] gridMengerSponge=newGrid(true);        //              -centers
boolean[][][] gridRemEdges=newGrid(false);           //        -edges
boolean[][][] gridRemCorners=newGrid(true);          //-corners
boolean[][][] gridLeaveEdges=newGrid(true);          //-corners      -centers
void initGrids() {
  gridMengerSponge[1][1][1]=false;
  gridMengerSponge[1][1][0]=false;
  gridMengerSponge[1][1][2]=false;
  gridMengerSponge[1][0][1]=false;
  gridMengerSponge[1][2][1]=false;
  gridMengerSponge[0][1][1]=false;
  gridMengerSponge[2][1][1]=false;
  
  gridMengerSpiky[1][1][1]=true;
  gridMengerSpiky[1][1][0]=true;
  gridMengerSpiky[1][1][2]=true;
  gridMengerSpiky[1][0][1]=true;
  gridMengerSpiky[1][2][1]=true;
  gridMengerSpiky[0][1][1]=true;
  gridMengerSpiky[2][1][1]=true;
  
  gridMengerSnowflake[0][0][0]=true;
  gridMengerSnowflake[2][0][0]=true;
  gridMengerSnowflake[0][2][0]=true;
  gridMengerSnowflake[0][0][2]=true;
  gridMengerSnowflake[2][2][0]=true;
  gridMengerSnowflake[2][0][2]=true;
  gridMengerSnowflake[0][2][2]=true;
  gridMengerSnowflake[2][2][2]=true;
  gridMengerSnowflake[1][1][1]=true;
  
  gridRemEdges[0][0][0]=true;
  gridRemEdges[0][0][2]=true;
  gridRemEdges[0][2][0]=true;
  gridRemEdges[2][0][0]=true;
  gridRemEdges[0][2][2]=true;
  gridRemEdges[2][0][2]=true;
  gridRemEdges[2][2][0]=true;
  gridRemEdges[2][2][2]=true;
  gridRemEdges[1][1][1]=true;
  gridRemEdges[0][1][1]=true;
  gridRemEdges[2][1][1]=true;
  gridRemEdges[1][0][1]=true;
  gridRemEdges[1][2][1]=true;
  gridRemEdges[1][1][0]=true;
  gridRemEdges[1][1][2]=true;
  
  gridRemCorners[0][0][0]=false;
  gridRemCorners[0][0][2]=false;
  gridRemCorners[0][2][0]=false;
  gridRemCorners[2][0][0]=false;
  gridRemCorners[2][2][0]=false;
  gridRemCorners[2][0][2]=false;
  gridRemCorners[0][2][2]=false;
  gridRemCorners[2][2][2]=false;
  
  gridLeaveEdges[0][0][0]=false;
  gridLeaveEdges[0][0][2]=false;
  gridLeaveEdges[0][2][0]=false;
  gridLeaveEdges[2][0][0]=false;
  gridLeaveEdges[2][2][0]=false;
  gridLeaveEdges[2][0][2]=false;
  gridLeaveEdges[0][2][2]=false;
  gridLeaveEdges[2][2][2]=false;
  gridLeaveEdges[1][1][1]=false;
  gridLeaveEdges[1][1][2]=false;
  gridLeaveEdges[1][0][1]=false;
  gridLeaveEdges[1][2][1]=false;
  gridLeaveEdges[0][1][1]=false;
  gridLeaveEdges[2][1][1]=false;
  
  
  
}
boolean[][][] newGrid(boolean bool) {
  boolean[][][]b=new boolean[3][3][3];
  for (int x=0; x<3; x++) {
    for (int y=0; y<3; y++) {
      for (int z=0; z<3; z++) {
        b[x][y][z]=bool;
      }
    }
  }
  return b;
}
void iterate() {
  ArrayList<Box>newboxes=new ArrayList<Box>();
  for (Box box : boxes) {
    Box[]news=box.iterate();
    for (Box newbox : news)newboxes.add(newbox);
  }
  boxes=newboxes;
}
class Box {
  PVector pos;
  float size;
  Box(float x, float y, float z, float s) {
    pos=new PVector(x, y, z);
    size=s;
  }
  void display() {
    //stroke(255);
    noStroke();
    colorMode(HSB, 100);
    float val=pos.mag();
    //color col=color(val,20,75);
    color col=color(val, 10, 100);
    colorMode(RGB, 255);
    //col=color(200,100);
    fill(col);
    //fill(200,20);
    stroke(col);
    //noStroke();
    //fill(0);
    pushMatrix();
    rotateX(rotX);
    rotateY(rotY);
    rotateZ(rotZ);
    translate(pos.x+size/2, pos.y+size/2, pos.z+size/2);
    //sphereDetail(5);
    //sphere(size);
    scale(0.99);
    box(size);
    popMatrix();
  }
  Box[] iterate() {
    int num=0;
    for (int x=0; x<3; x++)for (int y=0; y<3; y++)for (int z=0; z<3; z++)if (grid[x][y][z])num++;
    Box[]news=new Box[num];
    float ns=size/3;
    int counter=0;
    for (int x=0; x<3; x++) {
      for (int y=0; y<3; y++) {
        for (int z=0; z<3; z++) {
          if(grid[x][y][z]){
            news[counter]=new Box(x*ns,y*ns,z*ns,ns);
            counter++;
          }
        }
      }
    }
    //news[4]=new Box(0,0,ns,ns);
    //news[5]=new Box(0,ns,0,ns);
    //news[6]=new Box(ns,0,0,ns);
    for (Box b : news) {
      b.pos.x+=pos.x;
      b.pos.y+=pos.y;
      b.pos.z+=pos.z;
    }
    return news;
  }
}
boolean same(float x, float y, float z, float a, float b, float c) {
  return x==a&&y==b&&z==c;
}
ArrayList<Box>boxes;
float rotX=0, rotY=0, rotZ=0;
void draw() {
  background(0);
  rotY+=0.01;
  //pointLight(0,0,0,255,0,0);
  pointLight(255,255,255,0,0,0);
  ambientLight(150,150,150);
  if (keyPressed&&key=='a')rotY-=0.05;
  if (keyPressed&&key=='d')rotY+=0.05;
  if (keyPressed&&key=='w')rotX-=0.05;
  if (keyPressed&&key=='s')rotX+=0.05;
  if (keyPressed&&key=='q')rotZ-=0.05;
  if (keyPressed&&key=='e')rotZ+=0.05;
  PVector eye=new PVector(150, -100, 150);
  PVector center=new PVector(0, 10, 0);
  PVector up=new PVector(0, 1, 0);
  camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, up.x, up.y, up.z);
  noFill();
  stroke(255);
  for (Box b : boxes) {
    b.display();
  }
}