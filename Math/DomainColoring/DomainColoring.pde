float dens=1;
int pixelDens=2;
void setup() {
  float range=2;
  float rangeX=range, rangeY=range;
  size(6000, 6000);
  //size(512,512);
  pixelDensity(pixelDens);
  //width*=2;
  //height*=2;
  for (int tx=0; tx<width*pixelDens; tx+=dens) {
    if(tx%32==0){
      println(nf(100.0*tx/(width*pixelDens/dens),3,3)+"%, " + ((Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())/1000)+"kb");
    }
    for (int ty=0; ty<height*pixelDens; ty+=dens) {
      float x=map(tx, 0, width*pixelDens, -rangeX, rangeX);
      float y=map(ty, 0, height*pixelDens, -rangeY, rangeY);
      Complex complex=xy(x, y);

      //complex=julia(complex, 2, 15, 0, -0.8);
      complex=mandelbrot(complex, 2, 10, 1, 1);
      //complex=complex.c_cos().c_sin();
      //complex=complex.c_sin().c_cos();
      //complex=complex.c_cos();
      //complex=complex.c_sin();
      //complex=complex.c_cos().c_power(5);
      //complex=complex.c_sin().c_power(5);
      //complex=complex.c_add(-1,0).c_div(complex.c_add(1,0)).c_power(3);
      //complex=complex.c_power(-1).c_sin();
      //complex=complex.c_power(-1).c_cos();
      //complex=unityRoot(complex,4);
      //complex=complex.c_power(4);
      
      //Complex a=complex.c_power(2).c_add(-1,0);
      //Complex b=complex.c_add(-2,-1).c_power(2);
      //Complex c=complex.c_power(2).c_add(2,2);
      //complex=a.c_mult(b).c_div(c);

      color col=makeColor(complex);
      //if (dens>1) {
      fill(col);
      noStroke();
      //stroke(0);
      set(tx,ty,col);
      //rect(tx, ty, dens, dens);
      //} else {
      //set(tx, ty, col);
      //set(tx*pixelDens+1, ty*pixelDens, col);
      //set(tx*pixelDens, ty*pixelDens+1, col);
      //set(tx*pixelDens+1, ty*pixelDens+1, col);
      //}
    }
  }
  noLoop();
  println("DONE");
  save("mandelbrot-"+(pixelDens*width)+"x"+(pixelDens*height)+".png");
  println("DONE");
}

color makeColor(Complex c) {
  colorMode(HSB, 100);
  float p=0.2;
  float rad=abs(c.r);
  //float theta=sin(degrees(modAngle(c.theta)+PI)*TWO_PI/360)*0.5+0.5;//0 to 1
  //float theta=sin(degrees(modAngle(c.theta)+PI)*TWO_PI/360)*0.5+0.5;//0 to 1
  float theta=((modAngle(c.theta)+PI)/PI) * 180;
  float r=pow((rad-floor(rad)),p);
  float bright=1;
  //if(abs(theta-round(theta/30)*30)<1)bright=0;
  //bright-=(pow(abs(theta/thetaSpacing-round(theta/thetaSpacing)),2)>0.1?1:0);
  //bright= c.theta-floor(c.theta);
  float spacing=60;
  bright=1-pow(abs((theta-round(theta/spacing)*spacing)/90.0),4)*30;
  //bright=c.theta/thetaSpacing-floor(c.theta/thetaSpacing);
  //float satur=1-pow(2,-abs(c.r));
  //float satur=1-pow(-abs(c.r),2);
  float satur=c.r-floor(c.r);
  //while(satur>1x)satur-=10;
  //float satur=0;
  //float satur=cos(theta-round(theta*2)/2);
  //float satur=(theta%30)/30.0;
  //if(abs(theta-floor(theta/(30)*(30)))<0.1)satur=0;
  
  //color col=color(map(c.theta, -PI, PI, 0, 100),map(pow(2, -pow(c.r, 1)), 0, 1, 0, 100),100);
  color col=color(map(c.theta, -PI, PI, 0, 100),satur*100,(bright)*100);
  //color col=color(satur*100);
  colorMode(RGB, 255);
  return col;
}
float mod1(float f){
  f=cos(TWO_PI*f);
  while(f<0)f+=1;
  while(f>1)f-=1;
  return f;
}

Complex julia(Complex c, float f, int iters, float offX, float offY) {
  //return c.c_power(f).c_add(1,0);
  for (int i=0; i<iters; i++) {
    c=c.c_power(f).c_add(offX, offY);
  }
  return c;
}


Complex mandelbrot(Complex c, float f, int iters, float offX, float offY) {
  float origX=c.x()*offX;
  float origY=c.y()*offY;
  //return c.c_power(f).c_add(1,0);
  for (int i=0; i<iters; i++) {
    c=c.c_power(f).c_add(origX, origY);
  }
  return c;
}

Complex unityRoot(Complex c, float f) {
  return c.c_power(f).c_add(-1, 0);
}