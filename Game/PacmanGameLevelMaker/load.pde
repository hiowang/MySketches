void loadCollDotsMap(){
  String[] strs=loadStrings(lvlName+"-map-collision-dots.txt");
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
  String[] strs=loadStrings(lvlName+"-map-entity.txt");
  for(int x=0;x<gridW;x++){
    for(int y=0;y<gridH;y++){
      char c=strs[y].charAt(x);
      if(c=='G'){gX=x;gY=y;}
      if(c=='P'){pX=x;pY=y;}
    }
  }
}