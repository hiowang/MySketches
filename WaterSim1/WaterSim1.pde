float[][]u;
float[][]v;
int w=30;
int h=30;
float d=30;
void settings() {
  //w*d=1000
  //d=1000/w
  //d=1000/w;
  //size(int(w*d), int(h*d), P3D);
  size(1000,1000,P3D);
}
void setup() {
  u=new float[w][h];
  v=new float[w][h];
  for (int x=0; x<w; x++) {
    for (int y=0; y<h; y++) {
      if (x==0||y==0||x==w-1||y==h-1) {
        u[x][y]=0;
        v[x][y]=0;
      } else {
        //u[x][y]=(cos(x*0.05)*sin(y*0.05));
        u[x][y]=0;
        v[x][y]=0;
      }
    }
  }
}
void update() {
  float[][]newu=new float[w][h];
  for (int x=0; x<w; x++) {
    for (int y=0; y<h; y++) {
      //if (x==0||y==0||x==w-1||y==h-1) {
      //u[x][y]=0;
      //continue;
      //}
      float a=1;
      if (x==0) {
        u[0][y]=u[1][y]*a;
        continue;
      } else if (y==0) {
        u[x][0]=u[x][1]*a;
        continue;
      } else if (x==w-1) {
        u[w-1][y]=u[w-2][y]*a;
        continue;
      } else if (y==h-1) {
        u[x][h-1]=u[x][h-2]*a;
        continue;
      }
      float xmi=u[x-1][y];
      float xpl=u[x+1][y];
      float ymi=u[x][y-1];
      float ypl=u[x][y+1];
      v[x][y]+=0.25*xmi+0.25*xpl+0.25*ymi+0.25*ypl-u[x][y];
      v[x][y]*=0.66;//0.66
      u[x][y]+=v[x][y];
    }
  }
  //u=newu;
  //map=newMap;
}
float rot=0;
boolean isA=false, isD=false;
ArrayList<PVector>fullPos=new ArrayList<PVector>();
void keyPressed() {
  if (key=='a')isA=true;
  if (key=='d')isD=true;
  if (key==' ')isA=isD=false;
  if(key=='q')fullPos.add(new PVector(random(w),random(h)));
  if (key=='1') {
    u[int(random(1, w-1))][int(random(1, h-1))]+=-1;
  }
  if (key=='2') {
    u[int(random(1, w-1))][int(random(1, h-1))]+=-10;
  }
  if (key=='3') {
    u[int(random(1, w-1))][int(random(1, h-1))]+=-100;
  }
  if (key=='4')u[int(random(1, w-1))][int(random(1, h-1))]+=-250;
  if (key=='5')u[int(random(1, w-1))][int(random(1, h-1))]+=-500;
  if (key==' ') {

    u=new float[w][h];
    v=new float[w][h];
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        if (x==0||y==0||x==w-1||y==h-1) {
          u[x][y]=0;
          v[x][y]=0;
        } else {
          //u[x][y]=(cos(x*0.05)*sin(y*0.05));
          u[x][y]=0;
          v[x][y]=0;
        }
      }
    }
  }
}
void keyReleased() {
  if (key=='a')isA=false;
  if (key=='d')isD=false;
  if (key==' ')isA=isD=false;
}
void mousePressed() {
  //for(int x=1;x<w-1;x++){
  //u[x][h-1]=100;
  //}
  //u[int(random(1, w-1))][int(random(1, h-1))]=10;
  rain=!rain;
}
float getU(float x, float y) {
  return map(u[int(x)][int(y)], -2, 2, 0, 500);
}
boolean rain=false;
void draw() {
  //u[0][0]=0;
  //u[w-1][0]=0;
  //u[0][h-1]=0;
  //u[w-2][h-1]=0;
  for(PVector p:fullPos){
    u[int(p.x)][int(p.y)]=-2;
  }
  float s=0.01;
  if (isA)rot-=s;
  if (isD)rot+=s;
  if (rain) {
    for (int i=0; i<3; i++)u[int(random(1, w-1))][int(random(1, h-1))]+=random(-0.1,01);
  }
  //if(frameCount%1==0)
  //if (mousePressed)u[int(random(1, w-1))][int(random(1, h-1))]=10;
  //if(keyPressed)u[int(random(w))][int(random(h))]=2;
  //Rotation with 'a' and 'd' keys
  //Fix the bug where pillars of water pop up
  //Waves?
  background(#002831);
  camera(0, -1500, 2500, 0, 0, 500, 0, 1, 0);
  ambientLight(50, 50, 50);
  pointLight(200, 200, 200, 0, -500, 800);
  fill(255);
  stroke(0);
  //quad(-w*5,0,-w*5,w*5,0,-w*5,-w*5,0,w*5,w*5,0,w*5);
  for (int x=0; x<w-1; x++) {
    for (int y=0; y<h-1; y++) {
      noStroke();
      //stroke(#00AFD8);
      fill(0, 196, 242);
      pushMatrix();
      //rotateY(rot);
      translate(-w*d/2, -h*d/2);
      beginShape();
      vertex(x*d, getU(x, y), y*d);
      vertex(x*d+d, getU(x+1, y), y*d);
      vertex(x*d+d, getU(x+1, y+1), y*d+d);
      endShape(CLOSE);
      beginShape();
      vertex(x*d, getU(x, y), y*d);
      vertex(x*d+d, getU(x+1, y+1), y*d+d);
      vertex(x*d, getU(x, y+1), y*d+d);
      endShape(CLOSE);
      //beginShape();
      //vertex(x*d, getU(x, y), y*d);
      //vertex(x*d+d, getU(x+1, y), y*d);
      //vertex(x*d+d, getU(x+1, y+1), y*d+d);
      //vertex(x*d, getU(x, y+1), y*d+d);
      //endShape(CLOSE);
      popMatrix();
      //pushMatrix();
      //noStroke();
      //fill(0,196,242);
      //float h=map(u[x][y], 0, 5, 0, 500);
      //translate(-w*5, 0, -h*5);
      ////rotateY(rot);
      ////translate(x*10-w*5, 0, y*10-h*5);
      //translate(x*10, 0, y*10);
      //box(10, h, 10);
      //popMatrix();
    }
  }
  update();
  //for(int x=0;x<w;x++){
  //  for(int y=0;y<h;y++){
  //    float f=u[x][y];
  //    f=map(f,0,10,0,255);
  //    fill(0,0,f);
  //    noStroke();
  //    rect(x*width/w,y*height/h,width/w,height/h);
  //  }
  //}
}