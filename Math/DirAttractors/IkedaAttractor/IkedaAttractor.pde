float a=0.85;
float b=0.9;
float k=0.4;
float p=7.7;

Complex iterate(Complex z){
  return xy(a,0).c_add(z.c_mult(from_angle(k-p/(1+sq_length(z)))).c_mult(b));
}
void setup(){
  size(1000,1000);
  Complex c=xy(0,0);
  int[][]hits=new int[width][height];
  for(int i=0;i<100000000;i++){
    if(i%10000==0)println(i);
    c=iterate(c);
    float x=map(c.x(),-2,2,0,width);
    float y=map(c.y(),-2,2,0,height);
    hits[int(x)][int(y)]++;
    //set(int(x),int(y),color(0));
  }
  println("calculated");
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      set(x,y,color(hits[x][y]*0.1));
    }
  }
  println("rendered");
}