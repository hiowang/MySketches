int scale=1;
color[][] grid;
void setup() {
  fullScreen();
  println(displayDensity());
  pixelDensity(2);
  //fn=new FastNoise();
  calcGrid();
}
//FastNoise fn;
//float noiseMy(float x,float y){
//return fn.GetPerlin(x,y)/2f+0.5f;
//}
color ocean=color(0, 0, 255);
color rainForest=color(0, 255, 0);
color savanna=color(188.7, 178.5, 94.35);
color desert=color(237, 201, 175);
color savannaMountains=color(188.7+10, 178.5+10, 94.35+10);
color forest=color(50, 200, 50);
color taiga=color(127.5, 150, 50);
color mountains=color(200);
color snow=color(255);
float forestVal=41;
float ridgeNoise(float x, float y) {
  float n=noise(x, y);//[0,1]
  n*=-1;//[-1,0]
  n+=0.5;//[-0.5,-0.5]
  n=abs(n);//[0,0.5]
  n*=2;//[0,1]
  return 1-n;
}
void calcGrid() {
  drawing=true;
  grid=new color[width*2/scale][height*2/scale];
  //float zall=0.01/2;
  float zall=1;
  float zr = zall*0.1;
  float zt = zall*0.1;
  float za=zall*0.01;
  float zb=zall*0.01;
  float zc=zall*0.1;
  float zd=zall*0.01;
  float mi=10000, ma=-1000;
  for (int x=0; x<width*2/scale; x++) {
    for (int y=0; y<height*2/scale; y++) {
      grid[x][y]=color(0);
      //float noise=abs(-noise(x*0.0025,y*0.0025)+0.5)*2*100;
      float noise=ridgeNoise(x*0.01, y*0.01)*100;
      float a=noise(x*0.01+100, y*0.01+100)*100;
      float b=noise(x*0.01+200, y*0.01+200)*100;
      //float c=noise(x*0.01+300, y*0.01+300)*100;
      //float d=noise(x*0.01+400, y*0.01+400)*100;
      float e=noise(x*0.0025+500,y*0.0025+500)*115-15;
      //float c=
      //grid[x][y]=color(noise*255);
      if (noise>ma)ma=noise;
      if (noise<mi)mi=noise;
      //if(e>75)grid[x][y]=rainForest;
      else if(e<5)grid[x][y]=snow;
      else if(e<20)grid[x][y]=mountains;
      else if(e<30)grid[x][y]=taiga;
      else if(e<45)grid[x][y]=forest;
      else if(e<55)grid[x][y]=savanna;
      else if(e<65)grid[x][y]=forest;
      else if(e<100)grid[x][y]=desert;
      
      if (a>b)grid[x][y]=ocean;
      if (noise>98)grid[x][y]=ocean;
      
      //float noise=noise(x*0.01,y*0.01);
      //noise*=-1;
      //noise+=0.5;
      //noise=abs(noise);
      //noise*=2;
      //noise*=100;
      //println(noise);/
      //if(noise>49&&noise<51)grid[x][y]=ocean;
      //if(noise>75)grid[x][y]=ocean;
      //else grid[x][y]=color(255);
      //grid[x][y]=color(map(noise,0,100,0,255));
      //float r=noise(zr*x,zr*y)*100;
      //float t=noise(zt*x+100,zt*y+100)*100;
      //float a=noise(za*x+200,za*y+200)*100;
      //float b=noise(zb*x+300,zb*y+300)*100;
      //float c=noise(zc*x+400,zc*y+400)*100;
      //float d=noise(zd*x+500,zd*y+500)*100;
      //if(a>b-10)grid[x][y]=ocean;
      //if(d<40)grid[x][y]=color(255,0,0);

      //if(r*r+t*t>3500)grid[x][y]=ocean;
      //r=x
      //t=y
      //else 
      //if(r<30&&t<30)grid[x][y]=snow;
      //else if(r<35&&t<30)grid[x][y]=mountains;
      //else if(r<30&&t<35)grid[x][y]=taiga;
      //if(r<25&&t<30)grid[x][y]=snow;
      //else if(r<40&&t<35)grid[x][y]=mountains;
      //else if(r<40&&t<45)grid[x][y]=taiga;

      //else if(t>60&&r>60)grid[x][y]=savanna;
      //else if(t>50&&r>65)grid[x][y]=desert;
      //else if(t>50&&r>60)grid[x][y]=savannaMountains;

      //else if(t<30&&r>60)grid[x][y]=rainForest;

      //else if(t>forestVal&&t<100-forestVal&&r>forestVal&&r<100-forestVal)grid[x][y]=forest;
    }
  }
  println(mi+","+ma);
}
void keyPressed() {
  if (key == ' ') {
    noiseSeed((long)(Math.random()*Long.MAX_VALUE));
    calcGrid();
  }
  //forestVal+=0.5;
  //calcGrid();
}
boolean drawing=false;
void draw() {
  if (drawing) {
    background(0);
    for (int x=0; x<width*2/scale; x++) {
      for (int y=0; y<height*2/scale; y++) {
        noStroke();
        set(x, y, grid[x][y]);
        //fill(grid[x][y]);
        //rect(x*scale,y*scale,scale,scale);
      }
    }
    drawing=false;
  }
}