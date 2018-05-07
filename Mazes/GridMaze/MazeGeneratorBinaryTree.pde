class MazeGeneratorBinaryTree extends MazeGenerator {
  Grid generateMaze(int w, int h) {
    Grid grid=new Grid(w, h);

    return grid;
  }
  int x=0, y=0;
  void update() {
    //for (int i=0; i<grid.w; i++) {
    //for (int j=0; j<grid.h; j++) {
    if (x==sizeX) {
      x=0;
      y++;
    }
    if (y==sizeY){
      done=true;
      return;
    }
    ArrayList<Dir>dirs=new ArrayList<Dir>();
    //dirs.add(Dir.XPL);
    //dirs.add(Dir.YPL);
    if (x<grid.w-1)dirs.add(Dir.XPL);
    if (y<grid.h-1)dirs.add(Dir.YPL);
    if (dirs.size()==0){
      x++;
      return;
    }
    grid.setWall(x, y, dirs.get(int(random(dirs.size()))), true);
    x++;
    //}
    //}
  }
  boolean done=false;
  boolean isDone(){
    //return x==grid.w&&y==grid.h;
    return done;
  }
  PVector getColorScalar() {
    return new PVector(1, 0, 1);
  }
}