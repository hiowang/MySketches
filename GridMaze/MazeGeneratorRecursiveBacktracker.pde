class MazeGeneratorRecursiveBacktracker extends MazeGenerator {
  Grid generateMaze(int w, int h) {
    grid=new Grid(w, h);
    //ArrayList<Cell>finished=new ArrayList<Cell>();
    current=grid.cells[0][0];
    stack.add(current);
    return grid;
  }
  boolean first=true;
  ArrayList<Cell>stack=new ArrayList<Cell>();
  ArrayList<Cell>retraced=new ArrayList<Cell>();
  ArrayList<Cell>visited=new ArrayList<Cell>();
  Cell current;
  void update() {
    Dir dir=randDir();
    Cell proj;
    while(grid.outBounds(current.x+getDX(dir),current.y+getDY(dir))){
      dir=randDir();
    }
    proj=grid.cells[current.x+getDX(dir)][current.y+getDY(dir)];
    if(stack.contains(current)){
      //stack.remove(0);
      //current=stack.get(0);
      //return;
    }
    stack.add(current);
    grid.setWall(current,proj,true);
    current=proj;
    
  }
  PVector getColorScalar() {
    return new PVector(0, 1, 1);
  }
}