import arb.soundcipher.*;

boolean[] rules=new boolean[8];
SoundCipher sc;
void setup() {
  size(1024, 1024);
  initRules(false);
  sc=new SoundCipher(this);
  pitches=new float[numPitches];
  for (int i=0; i<numPitches; i++) {
    pitches[i]=random(50, 150);
    //pitches[i]=map(i,0,numPitches-1,50,100);
  }
  //for(int num=0;num<100;num++){
  //  int i=int(random(numPitches));
  //  int j=int(random(numPitches));
  //  float temp=pitches[i];
  //  pitches[i]=pitches[j];
  //  pitches[j]=temp;
  //}
  xOff=width/2-20;
}
int xOff;
float[]pitches;
int numPitches=30;
void initRules(boolean wait) {
  genNum=0;
  int num=86;
  for (int i=0; i<8; i++) {
    rules[i]=random(100)<50;
    //print(rules[i]?1:0);
  }
  //11000011: full right sierpinski triangle
  //rules=new int[]{0,0,1,0,1,1,0,1};
  //rules=new boolean[]{false,false,true,false,true,true,false,true};
  //println();
  //int power=128;
  //for (int i=0; i<8; i++) {
  //if (power>num) {
  //power/=2;
  //rules[i]=false;
  //} else {
  //num-=power;
  //println("POW: "+power+" "+num);
  //power/=2;
  //rules[i]=true;
  //}
  //println(rules[i]?1:0);
  //}
  for (boolean b : rules)print(b?1:0);
  println();

  if (wait)try {
    Thread.sleep(500);
  }
  catch(Throwable t) {
    t.printStackTrace();
  }
  println();
  background(255);
  for (int i=0; i<width; i++) {
    set(i, 0, random(100)<50?color(255):color(0));
    //set(i, 0, color(255));
    //if (i==0||i==width-2)for (int y=0; y<height; y++)set(i, y, color(255));
  }
  //set(width/2, 0, color(0));
}
void mousePressed() {
  initRules(false);
}
int genNum=0;
void draw() {
  xOff=mouseX;
  //for (int i=0; i<5; i++) {
  genNum++;
  if (genNum>=height) {
    //initRules(true);
    //genNum=0;
    for (int i=0; i<width; i++) {
      for (int y=height/2; y<height; y++) {
        set(i, y, get(i, y+1));
      }
      //set(i, 0, random(100)<50?color(255):color(0));
      //set(i, 0, color(255));
      //for (int y=0; y<=height; y++)set(i, y, color(255));
    }
    genNum--;
  }
  ArrayList<Float>list=new ArrayList<Float>();
  for (int x=1; x<width-1; x++) {
    boolean b1=(get(x-1, genNum-1)==color(255));
    boolean b2=(get(x, genNum-1)==color(255));
    boolean b3=(get(x+1, genNum-1)==color(255));
    int w1=4;
    int w2=2;
    int w3=0;
    int n=(b1?1:0)*w1+(b2?1:0)*w2+(b3?1:0)*w3;
    boolean rule=rules[n];
    set(x, genNum, rule?color(255):color(0));
    if (x>=xOff-numPitches/2&&x<xOff+numPitches/2) {
      if (rule) {
        list.add(pitches[x-(xOff-numPitches/2)]);

        set(x, genNum-2, color(255, 0, 0));
      }else{
        set(x,genNum-2,color(0,255,0));
      }
    }
  }
  while(list.size()>1)list.remove(0);
  //list.add(noise(frameCount*0.01)*50+100);
  float[]floats=new float[list.size()];
  for (int i=0; i<list.size(); i++)floats[i]=list.get(i);
  if (genNum<100)frameRate(60);
  else frameRate(10);
  sc.playChord(floats, 100, 1.0/frameRate);
  //sc.playNote(noise(frameCount*0.01)*50+100,100,1.0/frameRate);
  //}
  surface.setTitle("CA1D, frameRate="+nf(frameRate, 2, 3));
}