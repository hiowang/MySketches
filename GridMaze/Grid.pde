class Grid {
  void errorBounds(Cell c){
    errorBounds(c.x,c.y);
  }
  void errorCell(Cell c,String msg){
    errorCoords(c.x,c.y,msg);
  }
  void errorBounds(float x, float y) {
    errorBounds(int(x), int(y));
  }
  void errorCoords(float x, float y, String msg) {
    errorCoords(int(x), int(y), msg);
  }
  void errorBounds(int x, int y) {
    errorCoords(x, y, "is not a valid grid position");
  }
  void errorCoords(int x, int y, String msg) {
    println("ooops! "+x+","+y+" "+msg);
  }
  Cell[][]cells;
  int w, h;
  Grid(int a, int b) {
    w=a;
    h=b;
    cells=new Cell[w][h];
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        cells[x][y]=new Cell();
        cells[x][y].x=x;
        cells[x][y].y=y;
      }
    }
  }
  boolean outBounds(float x, float y) {
    return outBounds(int(x), int(y));
  }
  boolean outBounds(int x, int y) {
    return x<0||y<0||x>=w||y>=h;
  }
  boolean outBounds(Cell c){
    return outBounds(c.x,c.y);
  }
  boolean getWall(Cell c,Dir d){
    return getWall(c.x,c.y,d);
  }
  boolean getWall(float x, float y, Dir d) {
    return getWall(int(x), int(y), d);
  }
  boolean getWall(int x, int y, Dir d) {
    if (outBounds(x, y)) {
      errorBounds(x, y);
    }
    if (d==Dir.XMI) {
      if (x>0)return cells[x-1][y].right;
    }
    if (d==Dir.XPL) {
      return cells[x][y].right;
    }
    if (d==Dir.YMI) {
      if (y>0)return cells[x][y-1].down;
    }
    if (d==Dir.YPL) {
      return cells[x][y].down;
    }
    return false;
  }
  Cell getCellDir(Cell c,Dir d){
    if(outBounds(c)){
      errorBounds(c);
      return null;
    }
    if(d==Dir.XMI)if(c.x>0)return cells[c.x-1][c.y];
    if(d==Dir.XPL)if(c.x<w-1)return cells[c.x+1][c.y];
    if(d==Dir.YMI)if(c.y>0)return cells[c.x][c.y-1];
    if(d==Dir.YPL)if(c.y<h-1)return cells[c.x][c.y+1];
    return null;
  }
  ArrayList<Cell>getAllAdj(Cell c){
    ArrayList<Cell>list=new ArrayList<Cell>();
    //if(getWall(
    list.add(getCellDir(c,Dir.XMI));
    list.add(getCellDir(c,Dir.XPL));
    list.add(getCellDir(c,Dir.YMI));
    list.add(getCellDir(c,Dir.YPL));
    while(list.contains(null))list.remove(null);
    return list;
  }
  ArrayList<Cell>getValidAdj(Cell c){
    ArrayList<Cell>list=getAllAdj(c);
    for(int i=0;i<list.size();i++){
      if(!getWall(list.get(i),c))list.set(i,null);
    }
    while(list.contains(null))list.remove(null);
    return list;
  }
  boolean getWall(Cell a,Cell b){
    Dir d=dirFromDXDY(a.x-b.x,a.y-b.y);
    return getWall(b,d);
  }
  void setWall(Cell c,Dir d,boolean b){
    setWall(c.x,c.y,d,b);
  }
  void setWall(float x, float y, Dir d, boolean b) {
    setWall(int(x), int(y), d, b);
  }
  void setWall(int x, int y, Dir d, boolean b) {
    if (outBounds(x, y)) {
      errorBounds(x, y);
    }
    if (d==Dir.NONE||d==null)return;
    if (d==Dir.XMI) {
      if (x>0)cells[x-1][y].right=b;
    }
    if (d==Dir.XPL) {
      cells[x][y].right=b;
    }
    if (d==Dir.YMI) {
      if (y>0)cells[x][y-1].down=b;
    }
    if (d==Dir.YPL) {
      cells[x][y].down=b;
    }
  }
  void djikstraColoring(int size,int startX,int startY,float r,float g,float b){
    int[][]nums=new int[w][h];
    Cell[][]froms=new Cell[w][h];
    for(int x=0;x<w;x++){
      for(int y=0;y<h;y++){
        nums[x][y]=0;
        froms[x][y]=null;
      }
    }
    ArrayList<Cell>open=new ArrayList<Cell>();
    ArrayList<Cell>closed=new ArrayList<Cell>();
    //nums[startX][startY]=2;
    //ArrayList<Cell>list=getValidAdj(cells[startX][startY]);
    //for(Cell c:list){
    //  nums[c.x][c.y]=1;
    //}
    open.add(cells[startX][startY]);
    while(open.size()>0){
      Cell c=open.get(0);
      open.remove(0);
      if(!closed.contains(c))closed.add(c);
      ArrayList<Cell>list=getValidAdj(c);
      for(Cell newC:list){
        if(!closed.contains(newC)){
          open.add(newC);
          nums[newC.x][newC.y]=nums[c.x][c.y]+1;
        }
      }
    }
    
    int mi= 10000000;
    int ma=-10000000;
    for(int x=0;x<w;x++){
      for(int y=0;y<h;y++){
        if(nums[x][y]<mi)mi=nums[x][y];
        if(nums[x][y]>ma)ma=nums[x][y];
      }
    }
    for(int x=0;x<w;x++){
      for(int y=0;y<h;y++){
        float f=map(nums[x][y],mi,ma,255,0);
        //println(nums[x][y]);
        fill(r*f,g*f,b*f);
        noStroke();
        rect(x*size,y*size,size,size);
      }
    }
  }
  void displayWalls(int size, boolean bg) {
    if (bg)fill(150);
    else noFill();
    stroke(255);
    rect(0, 0, w*size, h*size);

    for (int cx=0; cx<w; cx++) {
      for (int cy=0; cy<h; cy++) {
        stroke(255);
        if (!getWall(cx, cy, Dir.XPL)) {
          line(size+cx*size, cy*size, size+cx*size, size+cy*size);
        }
        if (!getWall(cx, cy, Dir.YPL)) {
          line(cx*size, size+cy*size, size+cx*size, size+cy*size);
        }
      }
    }
  }
}