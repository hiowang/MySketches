class MazeGeneratorSidewinder extends MazeGenerator {
  PVector getColorScalar() {
    return new PVector(1, 1, 0);
  }

  Grid generateMaze(int w, int h) {
    Grid grid=new Grid(w, h);

    return grid;
  }
  int x=0, y=0;
  ArrayList<Cell>runSet=new ArrayList<Cell>();
  void update() {
    if (x==sizeX) {
      x=0;
      y++;
      runSet=new ArrayList<Cell>();
    }
    if (y==sizeY) {
      return;
    }
    if (y==0)grid.setWall(x, y, Dir.XPL, true);
    if (x==sizeX-1)grid.setWall(x, y, Dir.YPL, true);
    runSet.add(grid.cells[x][y]);
    if (chanceTrue(0.5)) {
      grid.setWall(pickRandom(runSet), Dir.YMI, true);
      runSet.clear();
    } else {
      grid.setWall(x, y, Dir.XPL, true);
    }
    x++;
    //}
    //}
  }
}