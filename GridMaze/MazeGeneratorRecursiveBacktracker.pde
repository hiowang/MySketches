class MazeGeneratorRecursiveBacktracker extends MazeGenerator {
  Grid generateMaze(int w, int h) {
    grid=new Grid(w, h);
    //ArrayList<Cell>finished=new ArrayList<Cell>();
    current=grid.cells[0][0];
    return grid;
  }
  ArrayList<Cell>stack=new ArrayList<Cell>();
  Cell current;
  void update(){
    ArrayList<Cell>adj=grid.getAllAdj(current);
    Cell next=pickRandom(adj);
    grid.setWall(next,current,true);
    current=next;
    //current=pickRandom(adj);
    if(current==null)return;
  }
  PVector getColorScalar() {
    return new PVector(0, 1, 1);
  }
}