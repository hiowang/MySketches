int w=250;
int h=250;
int size;
boolean three_d=false;
void settings() {
  size=1000/w;
  if (three_d)size(size*w, size*h, P3D);
  else size(size*w, size*h);
}
float[][]u, v;
void setup() {
  u=new float[w][h];
  v=new float[w][h];
  for (int x=0; x<w; x++) {
    for (int y=0; y<h; y++) {
      u[x][y]=0+cos(x*0.1)*cos(y*0.1)*5;
      v[x][y]=0;
    }
  }
}
//void mouseDragged() {
//}
void setu(int x, int y, float f) {
  if (x<0||y<0||x>=w||y>=h)return;
  u[x][y]=f;
}
void addu(int x, int y, float f) {
  if (x<0||y<0||x>=w||y>=h)return;
  u[x][y]+=f;
}
void mouseMoved() {
  for (float t=0; t<1; t+=0.01) {
    int x=int(lerp(pmouseX/size, mouseX/size, t));
    int y=int(lerp(pmouseY/size, mouseY/size, t));
    setu(x, y, 10);
    setu(x+1,y,5);
    setu(x-1,y,5);
    setu(x,y-1,5);
    setu(x,y+1,5);
  }
  //setu(mouseX/size,mouseY/size,10);
}
void draw() {
  background(255);
  for(int x=0;x<1;x++)updateSim();
  //if(keyPressed&&key==' '){
  //if (mousePressed)
  //int mx=mouseX/size;
  //int my=mouseY/size;
  //for(int x=0;x<1;x++)updateSim();
  //setu(mx,my,getu(mx,my)+0.1);
  //addu(mx,my,2);
  //addu(mx-1,my,5);
  //u[mx][my]=u[mx-1][my]=u[mx+1][my]=u[mx][my-1]=u[mx][my+1]=10;
  //u[int(mouseX/size)][int(mouseY/size)]+=100;
  //}
  println(frameRate);
  if (!three_d) {
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        fill(col(x, y));
        noStroke();
        rect(x*size, y*size, size, size);
      }
    }
  } else {
    camera(size*w, -size*w/2, size*w, 0, 0, 0, 0, 1, 0);
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        fill(col(x, y));
        stroke(col(x, y));
        noStroke();
        translate(-w*size/3, 0, -h*size/3);
        beginShape();
        vertex(x*size, scaledu(x, y), y*size);
        vertex(x*size+size, scaledu(x+1, y), y*size);
        vertex(x*size, scaledu(x, y+1), y*size+size);
        endShape();
        beginShape();
        vertex(x*size+size, scaledu(x+1, y), y*size);
        vertex(x*size, scaledu(x, y+1), y*size+size);
        vertex(x*size+size, scaledu(x+1, y+1), y*size+size);
        endShape();
        translate(w*size/3, 0, h*size/3);
      }
    }
  }
}
float scaledu(int x, int y) {
  return (-50*getu(x, y));
}
color col(int x, int y) {
  float f=1+getu(x, y)/5;
  //float f=getu(x,y);
  float r=0;
  float g=50;
  float b=100;
  return color(r*f, g*f, b*f);
}
void updateSim() {
  float[][]newu=new float[w][h];
  float[][]newv=new float[w][h];
  for (int x=0; x<w; x++) {
    for (int y=0; y<h; y++) {
      newu[x][y]=u[x][y];
      newv[x][y]=v[x][y];
    }
  }
  for (int x=0; x<w; x++) {
    for (int y=0; y<h; y++) {
      float xmi=getu(x-1, y);
      float xpl=getu(x+1, y);
      float ymi=getu(x, y-1);
      float ypl=getu(x, y+1);
      float mimi=getu(x-1, y-1);
      float mipl=getu(x-1, y+1);
      float plmi=getu(x+1, y-1);
      float plpl=getu(x+1, y+1);
      //float mimi=0, mipl=0, plmi=0, plpl=0;
      float here=getu(x, y);
      float avg=(xmi+xpl+ymi+ypl+mimi+mipl+plmi+plpl+here)/9;
      newv[x][y]+=(avg-here)/2;
      newv[x][y]*=0.99;
      newu[x][y]+=newv[x][y];
    }
  }
  for (int x=0; x<w; x++) {
    for (int y=0; y<h; y++) {
      u[x][y]=newu[x][y];
      v[x][y]=newv[x][y];
    }
  }
}
float getu(int x, int y) {
  if (x<0||y<0||x>=w||y>=h)return 0;
  return u[x][y];
}