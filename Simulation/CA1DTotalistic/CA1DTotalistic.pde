import arb.soundcipher.*;
SoundCipher sc;
float[] pitches;


int[] rules;
int[][]data;
color[]cols;
void setup() {
  size(1024, 1024);
  rules=new int[num];
  data=new int[width][height];
  cols=new color[num];
  pitches=new float[num];
  for (int i=0; i<num; i++)pitches[i]=random(50, 100);
  sc=new SoundCipher(this);
  for (int i=0; i<num; i++) {
    colorMode(HSB, 100);
    cols[i]=color(random(100), 50, 100);
    colorMode(RGB, 255);
  }
  initRules(false);
}
int num=7;
void initRules(boolean wait) {
  genNum=0;
  for (int i=0; i<num; i++) {
    //rules[i]=random(100)<50;
    rules[i]=int(random(num));
    print(rules[i]);
  }
  if (wait)try {
    Thread.sleep(500);
  }
  catch(Throwable t) {
    t.printStackTrace();
  }
  println();
  background(0);
  //for(int i=0;i<width;i++){
  //set(i,0,color(int(random(num))*255/num));
  //}
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      data[x][y]=0;
      if (y==0)data[x][y]=int(random(num));
    }
  }
}
void mousePressed() {
  initRules(false);
}
int genNum=0;
void draw() {
  //for (int i=0; i<5; i++) {
  genNum++;
  if (genNum>=height-1) {
    //initRules(true);
    //genNum=1;
    for (int y=1; y<height; y++) {
      for (int x=0; x<width; x++) {
        set(x, y-1, get(x, y));
      }
    }
    genNum--;
  }
  int marg=2;
  float[]list=new float[marg];
  for (int x=1; x<width-1; x++) {
    int b=round((data[x-1][genNum-1]+data[x][genNum-1]+data[x+1][genNum-1])/3.0);
    b=rules[b];
    data[x][genNum]=b;
    color col=cols[b];
    if (x>=width/2&&x<width/2+marg) {
      colorMode(HSB, 100);
      col=color(hue(col), 50, 100);
      colorMode(RGB, 255);
      list[x-width/2]=b;
    }
    set(x, genNum, col);
  }

  //double dynamic=100;
  //double duration=0.1;
  //sc.playNote(pitches[b], dynamic, duration);
  //if(frameCount%10==0)
  //sc.playChord(pitches,dynamic,duration);
  //}
  surface.setTitle("CA1DTotalistic, frameRate="+nf(frameRate, 2, 3));
}