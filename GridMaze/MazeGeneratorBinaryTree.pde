class MazeGeneratorBinaryTree extends MazeGenerator {
  Grid generateMaze(int w, int h) {
    Grid grid=new Grid(w, h);
    for (int i=0; i<grid.w; i++) {
      for (int j=0; j<grid.h; j++) {
        ArrayList<Dir>dirs=new ArrayList<Dir>();
        //dirs.add(Dir.XPL);
        //dirs.add(Dir.YPL);
        if (i<grid.w-1)dirs.add(Dir.XPL);
        if (j<grid.h-1)dirs.add(Dir.YPL);
        if (dirs.size()==0)continue;
        grid.setWall(i, j, dirs.get(int(random(dirs.size()))), true);
      }
    }
    return grid;
  }
  PVector getColorScalar() {
    return new PVector(1, 0, 1);
  }
}