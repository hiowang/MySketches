class MazeGeneratorRecursiveBacktracker extends MazeGenerator {
  Grid generateMaze(int w, int h) {
    Grid grid=new Grid(w, h);
    ArrayList<Cell>finished=new ArrayList<Cell>();
    Cell current=grid.cells[0][0];
    int i=0;
    while (i<10000&&finished.size()>0) {
      i++;
      ArrayList<Cell>neighbours=grid.getAllAdj(current);
      for (int k=0; k<neighbours.size(); k++) {
        if (finished.contains(neighbours.get(k)))neighbours.set(k, null);
      }
      //finished.add(0,newC);
      if (neighbours.size()==0) {
        finished.remove(0);
        current=finished.get(1);
        continue;
      }
      finished.add(0, current);
      neighbours=removeNull(neighbours);
      Cell newC=pickRandom(neighbours);
      grid.setWall(current, newC, true);
      current=newC;
    }
    return grid;
  }
  PVector getColorScalar() {
    return new PVector(0, 1, 1);
  }
}