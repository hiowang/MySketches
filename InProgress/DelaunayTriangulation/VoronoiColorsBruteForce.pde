
void calcCols(){
  println("New voronoi: frameCount="+frameCount);
  for(int x=0;x<width;x+=dens){
    for(int y=0;y<height;y+=dens){
      color bestCol=color(100,100,100);
      float bestDist=10000;
      for(int i=0;i<points.size();i++){
        PVector p=points.get(i);
        float dist=dist(x,y,p.x,p.y);
        if(dist<bestDist){
          bestDist=dist;
          bestCol=cols.get(i);
        }
      }
      //fill(bestCol);
      //noStroke();
      //rect(x,y,dens,dens);
      vorCols[x/dens][y/dens]=bestCol;
    }
  }
}