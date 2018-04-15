class MazeGeneratorSidewinder extends MazeGenerator {
  PVector getColorScalar() {
    return new PVector(1, 1, 0);
  }

  Grid generateMaze(int w, int h) {
    Grid grid=new Grid(w, h);
    for(int y=0;y<h;y++){
      ArrayList<Cell>runSet=new ArrayList<Cell>();
      for(int x=0;x<w;x++){
        if(y==0)grid.setWall(x,y,Dir.XPL,true);
        if(x==w-1)grid.setWall(x,y,Dir.YPL,true);
        runSet.add(grid.cells[x][y]);
        if(chanceTrue(0.25)){
          grid.setWall(pickRandom(runSet),Dir.YMI,true);
          runSet.clear();
        }else{
          grid.setWall(x,y,Dir.XPL,true);
        }
      }
    }
    return grid;
  }
}