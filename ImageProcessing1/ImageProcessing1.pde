PImage img;
void settings() {
  img=loadImage("img1.jpg");
  size(img.width, img.height);
}
void setup() {
  angs=new float[width][height];
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      angs[x][y]=random(TWO_PI);
    }
  }
}
float[][]angs;
void draw() {
  background(0);
  image(img, 0, 0, width, height);
  float sampleRad=10;
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      float ang=angs[x][y]+random(-0.1,0.1);
      float dx=cos(ang)*sampleRad;
      float dy=sin(ang)*sampleRad;
      while (x+dx<0||y+dy<0||x+dx>=width||y+dy>=height) {
        ang+=random(-0.1,0.1);
        dx=cos(ang)*sampleRad;
        dy=sin(ang)*sampleRad;
      }
      angs[x][y]=ang;
      set(x, y, img.get(int(x+dx), int(y+dy)));
    }
  }
}