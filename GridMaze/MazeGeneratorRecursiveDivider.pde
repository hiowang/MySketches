class MazeGeneratorRecursiveDivider extends MazeGenerator {
  Grid generateMaze(int w, int h) {
    Grid g=new Grid(w, h);
    //grid.clearWalls();
    for (int x=0; x<w; x++) {
      //grid.cells[x][0].down=grid.cells[x][0].right=true;
      for (int y=0; y<h; y++) {
        g.cells[x][y].down=g.cells[x][y].right=true;
      }
    }
    println("CLEAR");
    grid=g;
    divide(0,0,w,h);

    return g;
  }
  void divide(int x, int y, int w, int h) {
    if (w<=2||h<=2)return;
    boolean horizDiv=true;
    if(horizDiv){
      int div=int(random(h-1));
      for(int theX=x;theX<x+w;theX++){
        if(div+x!=theX){
          grid.setWall(theX,div,Dir.YPL,false);
        }
      }
      println(div);
      divide(x,y,w,div-1);
      //divide(x,y+div+1,w,h-div);
      //divide(x,y,w,div);
      //divide(x+div,y,w-div,div);
    }else{
      int div=int(random(w-1));
      for(int theY=y;theY<y+h;theY++){
        if(div+y!=theY){
          grid.setWall(div,theY,Dir.XPL,false);
        }
      }
      divide(x,y,div,h);
      divide(x+div,y,w-div,h);
      //divide(x,y,div,h);
      //divide(x,y+div,
    }
  }
  void update() {
  }
  PVector getColorScalar() {
    return new PVector(0, 1, 0);
  }
}