PGraphics graphics;
class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  ArrayList<Rect>makeNew() {
    ArrayList<Rect>r=new ArrayList<Rect>();
    r.add(new Rect(x, y, w/2, h/2));
    r.add(new Rect(x+w/2, y, w/2, h/2));
    r.add(new Rect(x, y+h/2, w/2, h/2));
    r.add(new Rect(x+w/2, y+h/2, w/2, h/2));
    return r;
  }
  color avgCol() {
    float r=0;
    float g=0;
    float b=0;
    for (int i=int(x); i<=x+w; i++) {
      for (int j=int(y); j<=y+h; j++) {
        color col=graphics.get(i, j);
        r+=red(col);
        g+=green(col);
        b+=blue(col);
      }
    }
    r/=w*h;
    g/=w*h;
    b/=w*h;
    return color(r, g, b);
  }
  float avgDiff() {
    color avg=avgCol();
    float avgr=red(avg);
    float avgg=green(avg);
    float avgb=blue(avg);
    float diff=0;
    for (int i=int(x); i<=x+w; i++) {
      for (int j=int(y); j<=y+h; j++) {
        color col=graphics.get(i, j);
        diff+=avgr-red(col);
        diff+=avgg-green(col);
        diff+=avgb-blue(col);
      }
    }
    return diff;
  }
}
ArrayList<Rect>list;
void setup() {
  size(500, 500);
  graphics=createGraphics(width, height);
  graphics.beginDraw();
  graphics.background(255);
  for (int x=0; x<width; x++) {
    ////graphics.stroke(0);
    //graphics.set(int(x),int(height*noise(x*0.0025)),color(0));
    float a=x;
    float b=noise(x*0.01)*height;
    graphics.fill(0);
    graphics.noStroke();
    graphics.ellipse(a, b, 3, 3);
    //for(int y=0;y<height;y++){
      //noiseDetail(1);
      //graphics.set(x,y,color(noise(x*0.01,y*0.01)*255));
    //}
  }
  graphics.endDraw();
  list=new ArrayList<Rect>();
  list.add(new Rect(0, 0, width, height));
}
void draw() {
  background(255);
  //image(graphics,0,0,width,height);
  for (Rect r : list) {
    color c=r.avgCol();
    fill(c);
    noStroke();
    //fill(r.avgDiff()/3);
    stroke(0,20);
    rect(r.x, r.y, r.w, r.h);
  }
  //image(graphics,0,0);
  //for (int i=0; i<200; i++) {
    iterate();
  //}
}
void iterate() {
  int ind=0;
  float maxbad=-1;
  //boolean found=false;
  for (int i=0; i<list.size(); i++) {
    Rect r=list.get(i);
    float bad=r.avgDiff();
    if (bad>maxbad&&r.w*r.h>64) {
      //println("found");
      maxbad=bad;
      ind=i;
      //found=true;
    }
  }
  if(maxbad==-1){
    println("no more squares to divide");
    return;
  }
  //if(!found){
    //println("no more squares to divide");
    //return;
  //}
  Rect r=list.get(ind);
  list.remove(r);
  list.addAll(r.makeNew());
}