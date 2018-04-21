class MazeGeneratorRecursiveBacktracker extends MazeGenerator {
  Grid generateMaze(int w, int h) {
    grid=new Grid(w, h);
    //ArrayList<Cell>finished=new ArrayList<Cell>();
    current=grid.cells[0][0];
    return grid;
  }
  ArrayList<Cell>stack=new ArrayList<Cell>();
  Cell current;
  boolean first=true;
  void update(){
    if(!first&&stack.size()<1){
      first=false;
      return;
    }
    ArrayList<Cell>adj=grid.getAllAdj(current);
    for(int i=0;i<adj.size();i++){
      if(stack.contains(adj.get(i)))adj.set(i,null);
    }

    adj=removeNull(adj);
    if(adj.size()==0){
      while(adj.size()==0){
        stack.remove(0);
        current=stack.get(0);
        adj=grid.getAllAdj(current);
        for(int i=0;i<adj.size();i++){
          if(stack.contains(adj.get(i)))adj.set(i,null);
        }
        adj=removeNull(adj);
      }
      return;
    }
    stack.add(0,current);
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