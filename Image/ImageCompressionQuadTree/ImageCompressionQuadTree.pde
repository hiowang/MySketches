class Rect {
  float x, y, w, h;
  ArrayList<Rect>divide() {
    ArrayList<Rect>list=new ArrayList<Rect>();
    list.add(new Rect(x, y, w/2, h/2));
    list.add(new Rect(x+w/2, y, w/2, h/2));
    list.add(new Rect(x, y+h/2, w/2, h/2));
    list.add(new Rect(x+w/2, y+h/2, w/2, h/2));
    return list;
  }
  color col;
  void display() {
    fill(col);
    if (doStroke)stroke(0, 125);
    else noStroke();

    //fill(error(),0,0);

    if (doRect)rect(x, y, w, h);
    else ellipse(x+w/2, y+h/2, w, h);
  }
  float area() {
    return w*h;
  }
  float err;
  float error() {
    float colr=red(col);
    float colg=green(col);
    float colb=blue(col);
    float diffr, diffg, diffb;
    diffr=diffg=diffb=0;
    for (float a=x; a<x+w; a++) {
      for (float b=y; b<y+h; b++) {
        color c=img.get(int(map(a, 0, width, 0, img.width)), int(map(b, 0, height, 0, img.height)));
        diffr+=abs((float)colr-red(c))/area();
        diffg+=abs((float)colg-green(c))/area();
        diffb+=abs((float)colb-blue(c))/area();
      }
    }
    //diffr/=area();
    //diffg/=area();
    //diffb/=area();
    return (diffr+diffg+diffb)*pow(area(), 0.1);
    //return pow(area(),1);
  }
  Rect(float a, float b, float c, float d) {
    //col=img.get(int(map(a, 0, width, 0, img.width)), int(map(b, 0, height, 0, img.height)));
    //float colr=0,colg=0,colb=0;
    //for(float u=a;u<a+c;u++){
    //for(float v=b;v<b+d;v++){
    //color thecol=img.get(int(map(u, 0, width, 0, img.width)), int(map(v, 0, height, 0, img.height)));
    //colr+=red(thecol);
    //colg+=green(thecol);
    //colb+=blue(thecol);
    //}
    //}
    //col=color(colr/b/d,colg/b/d,colb/b/d);
    x=a;
    y=b;
    w=c;
    h=d;
    calcCol();
  }
  void calcCol() {
    float colr=0, colg=0, colb=0;
    float area=w*h;
    for (float a=x; a<x+w; a++) {
      for (float b=y; b<y+h; b++) {
        color c=img.get(int(map(a, 0, width, 0, img.width)), int(map(b, 0, height, 0, img.height)));
        colr+=red(c)/area;
        colg+=green(c)/area;
        colb+=blue(c)/area;
      }
    }
    col=color(colr, colg, colb);
  }
}
PImage img;
void settings() {
  //apple
  imgName="circle/normal";
  extension="png";
  img=loadImage(imgName+"."+extension);
  size(1024, 1024);
  //size(300,300);
}
String imgName, extension;

boolean doStroke=false;
boolean doRect=true;
void setup() {
  rects.add(new Rect(0, 0, width, height));
}
float errThreshold=10;
float areaThreshold=sq(8);
void keyPressed() {
  if (key=='s')doStroke=!doStroke;
  if (key=='r')doRect=!doRect;
  if (key==' ')doIterate=!doIterate;
  if (key=='t') {
    //save("processed-"+str);
    if (doStroke) {
      if (doRect) {
        save("saved_images/"+imgName+"/stroke-rect.png");
      } else {
        save("saved_images/"+imgName+"/stroke-ellipse.png");
      }
    } else {
      if (doRect) {
        save("saved_images/"+imgName+"/nostroke-rect.png");
      } else {
        save("saved_images/"+imgName+"/nostroke-ellipse.png");
      }
    }
  }
}
boolean doIterate=false;
void mousePressed() {
  //long start,end;
  //errThreshold-=1000;
  //start=System.currentTimeMillis();
  //int n=20;
  for (int i=0; i<100; i++)iterate();
  //end=System.currentTimeMillis();
}
float iterate() {
  num++;
  Rect largestErr = rects.get(0);
  float err=0;
  for (Rect r : rects) {
    if (r.area()<areaThreshold)continue;
    float e=r.error();
    if (e<errThreshold)continue;
    if (e>=err) {
      largestErr=r;
      err=e;
    }
  }
  if (err<errThreshold)return err;
  if (largestErr.area()<areaThreshold)return err;
  lastErrDiff=err-errThreshold;
  rects.remove(largestErr);
  rects.addAll(largestErr.divide());
  return err;
}
float lastErrDiff=0;
float diff(color a, color b) {
  return rdiff(a, b)+gdiff(a, b)+bdiff(a, b);
}
float rdiff(color a, color b) {
  return abs(red(a)-red(b));
}
float gdiff(color a, color b) {
  return abs(green(a)-green(b));
}
float bdiff(color a, color b) {
  return abs(blue(a)-blue(b));
}
ArrayList<Rect>rects=new ArrayList<Rect>();
int num=0;
void draw() {
  if (doIterate)for(int i=0;i<10;i++)iterate();
  //if (iterate()>errThreshold)for (int i=0; i<2; i++)iterate();
  background(255);
  for (Rect r : rects)r.display();
  //for (Rect r : rects) {
  //  if (r.x<mouseX&&r.x+r.w>mouseX) {
  //    if (r.y<mouseY&&r.y+r.h>mouseY) {
  //      println(r.error());
  //      stroke(0);
  //      noFill();
  //      rect(r.x, r.y, r.w, r.h);
  //    }
  //  }
  //}
  surface.setTitle("ImageCompressionQuadTree, frame rate="+nf(frameRate, 2, 3)+", frame count="+frameCount+", number rects="+rects.size()+", err left: "+nf(lastErrDiff, 13, 0));
}