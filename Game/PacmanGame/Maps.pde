void loadCollDotsMap(){
  String[] strs=loadStrings(levelName+"-map-collision-dots.txt");
  collMap=new boolean[gridW][gridH];
  dots=new boolean[gridW][gridH];
  powerPellets=new boolean[gridW][gridH];
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      powerPellets[x][y]=(strs[y].charAt(x)=='P');
      collMap[x][y]=(strs[y].charAt(x)=='#');
      dots[x][y]=(strs[y].charAt(x)=='.');
    }
  }
}
void loadEntityMap(){
  String[] strs=loadStrings(levelName+"-map-entity.txt");
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      char c=strs[y].charAt(x);
      if(c=='G'){
        blinky.gridX=x;
        blinky.gridY=y;
        inky.gridX=x;
        inky.gridY=y;
        pinky.gridX=x;
        pinky.gridY=y;
        clyde.gridX=x;
        clyde.gridY=y;
        ghostX=x;
        ghostY=y;
      }
      if(c=='P'){player.gridX=x;player.gridY=y;}
    }
  }
}
Node nearestOpen(Node n){
  Node nearest=new Node(0,0);
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      if(collMap[x][y])continue;
      if(abs(x-n.x)+abs(y-n.y)<abs(x-nearest.x)+abs(y-nearest.y)){
        nearest=new Node(x,y);
      }
    }
  }
  return nearest;
}