//4:3.5 aspect ratio
float mult=1000;
void settings() {
  size(int(3.5*mult), int(4*mult));
  pixelDensity(2);
}
/*
 x0 = scaled x coordinate of pixel (scaled to lie in the Mandelbrot X scale (-2.5, 1))
 y0 = scaled y coordinate of pixel (scaled to lie in the Mandelbrot Y scale (-1, 1))
 x = 0.0
 y = 0.0
 iteration = 0
 max_iteration = 1000
 // Here N=2^8 is chosen as a reasonable bailout radius.
 while ( x*x + y*y < (1 << 16)  AND  iteration < max_iteration ) {
 xtemp = x*x - y*y + x0
 y = 2*x*y + y0
 x = xtemp
 iteration = iteration + 1
 }
 // Used to avoid floating point issues with points inside the set.
 if ( iteration < max_iteration ) {
 // sqrt of inner term removed using log simplification rules.
 log_zn = log( x*x + y*y ) / 2
 nu = log( log_zn / log(2) ) / log(2)
 // Rearranging the potential function.
 // Dividing log_zn by log(2) instead of log(N = 1<<8)
 // because we want the entire palette to range from the
 // center to radius 2, NOT our bailout radius.
 iteration = iteration + 1 - nu
 }
 color1 = palette[floor(iteration)]
 color2 = palette[floor(iteration) + 1]
 // iteration % 1 = fractional part of iteration.
 color = linear_interpolate(color1, color2, iteration % 1)
 plot(Px, Py, color)
 */
color col(float num) {
  if (num>=30) {
    return color(0, 0, 0);
  } else {
    return color(map(num, 0, 20, 0, 100));
    //return color(map(num, 0, 20, 0, 100),100,100);
    //return color(100,map(num, 0, 20, 0, 100),100);
    //return color(100,100,map(num, 0, 20, 0, 100));
  }
}
void setup() {
  width*=2;
  height*=2;
  float d=1;
  for (int x=0; x<width; x+=d) {
    for (int y=0; y<height; y+=d) {
      float origx=map(x, 0, width, -2, 1.5);
      float origy=map(y, 0, height, -2, 2);

      float mapx=origx;
      float mapy=origy;
      float num=0;
      while (sq(mapx)+sq(mapy)<1048576&&num<30) {
        float newx=mapx*mapx-mapy*mapy;
        float newy=2*mapx*mapy;
        mapx=newx+origx;
        mapy=newy+origy;
        num++;
      }
      //colorMode(HSB, 100, 100, 100);
      colorMode(RGB, 100, 100, 100);
      if ( num < 30 ) {
        // sqrt of inner term removed using ;log simplification rules.
        float log_zn = log( mapx*mapx + mapy*mapy ) / 2;
        float nu = log( log_zn / log(2) ) / log(2);
        // Rearranging the potential function.
        // Dividing log_zn by log(2) instead of log(N = 1<<8)
        // because we want the entire palette to range from the
        // center to radius 2, NOT our bailout radius.
        //iteration = iteration + 1 - nu
        //num=num+1-nu;
        num=30-(num-1-8+8*nu);
      }
      color c1=col(floor(num));
      color c2=col(floor(num)+1);
      //println(num%1);
      color col=lerpColor(c1,c2,num%1);
      //color col=col(num-(1/30)*sqrt(sq(mapx)+sq(mapy)));
      if(d==1){
        set(int(x),int(y),col);
      }else{
        fill(col);
        stroke(col);
        rect(x,y,d,d);
      }
    }
  }
  save("mandelbrot.png");
  exit();
}