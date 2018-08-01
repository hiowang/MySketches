void setup() {
  size(500, 500);
  //pixelDensity(2);
  //width*=2;
  //height*=2;
}
void draw() {
  background(255);
  float d=1;
  for (int x=0; x<width; x+=d) {
    for (int y=0; y<height; y+=d) {
      color c=getCol(x, y);
      //set(x,y,c);
      noStroke();
      fill(c);
      rect(x, y, d, d);
    }
  }
  noLoop();
}
color getCol(int x, int y) {
  //float a=map(mouseX,0,width,-2,2);
  float a=1.0;
  Complex c=xy(map(x, 0, width, -2, 2), map(y, 0, height, -2, 2));
  int iters=0;
  int maxIters=50;
  while (iters<maxIters) {
    iters++;
    c=c.c_add( (func(c).c_div(deriv(c))).c_mult(-a));
    float tolerance=0.001;
    for (int i=0; i<roots.length; i++) {
      Complex diff=c.c_add( roots[i].c_mult(-1) );
      if (diff.r<tolerance) {
        color col=cols[i];
        colorMode(HSB, 100);
        col=color(hue(col), saturation(col), map(iters, 0, maxIters/3, 0, 100));
        colorMode(RGB, 255);
        return col;
      }
    }
  }
  return color(0);
}

Complex[]roots=new Complex[]{xy(1, 0), xy(-0.5, sqrt(3)/2), xy(-0.5, -sqrt(3)/2)};
color[]cols=new color[]{color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)};

Complex func(Complex c) {
  return c.c_power(3).c_add(-1, 0);
}
Complex deriv(Complex c) {
  return c.c_power(2).c_mult(xy(3, 0));
}


color makeColor(Complex c) {
  colorMode(HSB, 100);
  float p=0.2;
  float rad=abs(c.r);
  //float theta=sin(degrees(modAngle(c.theta)+PI)*TWO_PI/360)*0.5+0.5;//0 to 1
  //float theta=sin(degrees(modAngle(c.theta)+PI)*TWO_PI/360)*0.5+0.5;//0 to 1
  float theta=((modAngle(c.theta))/PI) * 180;
  float r=pow((rad-floor(rad)), p);
  float bright=1;
  //if(abs(theta-round(theta/30)*30)<1)bright=0;
  //bright-=(pow(abs(theta/thetaSpacing-round(theta/thetaSpacing)),2)>0.1?1:0);
  //bright= c.theta-floor(c.theta);
  float spacing=60;
  bright=1-pow(abs((theta-round(theta/spacing)*spacing)/90.0), 4)*30;
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
  color col=color(map(c.theta, -PI, PI, 0, 100), satur*100, (bright)*100);
  //color col=color(satur*100);
  colorMode(RGB, 255);
  return col;
}