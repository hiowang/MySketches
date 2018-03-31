int scale=10;
class Obstacle {
  int remLight;
  int x, y;
}
class Light {
  color col;
  int x, y;
}
ArrayList<Light>lights;
ArrayList<PVector>obsts;
void setup() {
  size(500,500);
  //fullScreen();
  lights=new ArrayList<Light>();
  obsts=new ArrayList<PVector>();
  for(int i=0;i<5;i++){
  addLight((int)random(width/scale),(int)random(height/scale));
  }
  float z=0.1;
  float thresholdMi=0.4;
  float thresholdMa=0.6;
  for(int x=0;x<width/scale;x++){
    //obsts.add(new PVector(x,0));
    //obsts.add(new PVector(x,2));
    for(int y=0;y<height/scale;y++){
      //if(noise(x*z,y*z)<thresholdMa&&noise(x*z,y*z)>thresholdMi)obsts.add(new PVector(x,y));
    }
  }
}

//corners take away 3 times as much light

void addLight(int x, int y) {
  Light l = new Light();
  l.col=color(random(100,200), random(100,200), random(100,200));
  //l.col=color(200);
  l.x=x;
  l.y=y;
  lights.add(l);
}

void keyPressed() {
  if (key=='l') {
    addLight(mouseX/scale, mouseY/scale);
  }
}
void mouseDragged() {
  obsts.add(new PVector(mouseX/scale, mouseY/scale));
}
float colLoss = 0.001;
color addCol(color a, color b) {
  return color(red(a)+red(b), green(a)+green(b), blue(a)+blue(b));
}
void draw() {

  color[][] vals = new color[width/scale][height/scale];
  for (Light lPos : lights) {
    ArrayList<PVector>open = new ArrayList<PVector>();
    ArrayList<PVector>closed = new ArrayList<PVector>();
    color curCol = lPos.col;
    open.add(new PVector(lPos.x, lPos.y));
    while (open.size()>0) {
      PVector pos = open.get(0);
      open.remove(0);
      //if(open.contains(pos))continue;
      if (closed.contains(pos))continue;
      if (obsts.contains(pos))continue;
      closed.add(pos);
      if (pos.x<0)continue;
      if (pos.y<0)continue;
      if (pos.x>=width/scale)continue;
      if (pos.y>=height/scale)continue;
      vals[(int)pos.x][(int)pos.y]=addCol(curCol, vals[(int)pos.x][(int)pos.y]);
      if (red(curCol)>4) {
        PVector xmi=new PVector(pos.x-1, pos.y);
        open.add(xmi);
        PVector xpl=new PVector(pos.x+1, pos.y);
        open.add(xpl);
        PVector ymi=new PVector(pos.x, pos.y-1);
        open.add(ymi);
        PVector ypl=new PVector(pos.x, pos.y+1);
        open.add(ypl);
      }
      curCol=color(red(curCol)-0.0001, green(curCol)-0.0001, blue(curCol)-0.0001);
    }
  }

  for (int x=0; x<width/scale; x++) {
    for (int y=0; y<height/scale; y++) {
      vals[x][y]=addCol(vals[x][y],color(30));
      fill(vals[x][y]);
      if (obsts.contains(new PVector(x, y)))fill(0, 255, 0);
      noStroke();
      rect(x*scale, y*scale, scale, scale);
    }
  }
}