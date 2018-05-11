int[] rules;
int[][]data;
color[]cols;
void setup() {
  size(1024, 1024);
  rules=new int[num];
  data=new int[width][height];
  cols=new color[num];
  for(int i=0;i<num;i++){
    colorMode(HSB,100);
    cols[i]=color(random(100),50,100);
    colorMode(RGB,255);
  }
  initRules(false);
}
int num=10;
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
      if(y==0)data[x][y]=int(random(num));
    }
  }
}
void mousePressed() {
  initRules(false);
}
int genNum=0;
void draw() {
  for (int i=0; i<5; i++) {
    genNum++;
    if (genNum>=height-1) {
      initRules(true);
      genNum=1;
    }
    for (int x=1; x<width-1; x++) {
      int b=round((data[x-1][genNum-1]+data[x][genNum-1]+data[x+1][genNum-1])/3.0);
      b=rules[b];
      data[x][genNum]=b;
      set(x,genNum,cols[b]);
      //int b1=int(red(get(x-1, genNum-1))/color(255/num));
      //int b2=int(red(get(x, genNum-1))/(255/num));
      //int b3=int(red(get(x+1, genNum-1))/(255/num));
      //int b=(b1+b2+b3)/num;
      //int b=
      //set(x, genNum, color(rules[b]*255/num));
      //boolean b1=get(x-1,genNum-1)==color(255);
      //boolean b2=get(x,genNum-1)==color(255);
      //boolean b3=get(x+1,genNum-1)==color(255);
      //int n=(b1?1:0)*4+(b2?1:0)*2+(b3?1:0);
      //set(x,genNum,rules[n]?color(255):color(0));
    }
  }
}