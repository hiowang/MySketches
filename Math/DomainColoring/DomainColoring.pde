float dens=1;
int pixelDens=2;
void setup() {
  float range=2;
  float rangeX=range, rangeY=range;
  size(1024, 1024);
  pixelDensity(pixelDens);
  //width*=2;
  //height*=2;
  for (int tx=0; tx<width; tx+=dens) {
    for (int ty=0; ty<height; ty+=dens) {
      float x=map(tx, 0, width, -rangeX, rangeX);
      float y=map(ty, height, 0, -rangeY, rangeY);
      Complex complex=xy(x, y);

      complex=julia(complex, 2, 10, 0, -0.8);
      //complex=mandelbrot(complex, 2, 30, 1, 1);
      //complex=complex.c_cos().c_sin();
      //complex=complex.c_sin().c_cos();
      //complex=complex.c_cos();
      //complex=complex.c_sin();
      //complex=complex.c_add(-1,0).c_div(complex.c_add(1,0)).c_power(3);
      //complex=complex.c_power(-1).c_sin();
      //complex=complex.c_power(-1).c_cos();
      //complex=unityRoot(complex,4);

      color col=makeColor(complex);
      //if (dens>1) {
      fill(col);
      noStroke();
      //stroke(0);
      rect(tx, ty, dens, dens);
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
}

color makeColor(Complex c) {
  colorMode(HSB, 100);
  color col=color(map(c.theta, -PI, PI, 0, 100), 100, map(1-pow(2, -pow(c.r, 1)), 0, 1, 0, 100));
  colorMode(RGB, 255);
  return col;
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