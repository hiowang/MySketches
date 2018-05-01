

float gravX;
float gravY;

GUIMenu menuUI;
GUIMenu menuNew;
GUIMenu menuDelete;
GUIMenu menuGrav;
GUIMenu menuWind;

GUILabel lblGravX,lblGravY;
GUILabel lblWindX,lblWindY;

GUIButton itemNewPoint,itemNewEdge;
GUIButton itemDelPoint,itemDelEdge;
GUIButton gravMi,gravPl;
GUIButton windMi,windPl;

void initGUI(){
  
  menuUI=new GUIMenu(5,5,100,15,"Options",2.5,3);
  menuNew=menuUI.addMenu("New");
  menuDelete=menuUI.addMenu("Delete");
  menuGrav=menuUI.addMenu("Gravity");
  menuWind=menuUI.addMenu("Wind");
  
  itemNewPoint=menuNew.addButton("New point",new GUIPrintEvent("New point"));
  itemNewPoint.addKey('p');
  itemNewEdge=menuNew.addButton("New edge",new GUIPrintEvent("New edge"));
  itemNewEdge.addKey('e');
  
  itemDelPoint=menuDelete.addButton("Delete point",new GUIPrintEvent("Delete point"));
  itemDelPoint.addKey('d');
  itemDelEdge=menuDelete.addButton("Delete edge",new GUIPrintEvent("Delete edge"));
  itemDelEdge.addKey('l');
  
  lblGravY=menuGrav.addLabel("Grav: ");
  gravMi=menuGrav.addButton("Grav-",new GUIPrintEvent("Grav-"));
  gravPl=menuGrav.addButton("Grav+",new GUIPrintEvent("Grav+"));
  
  lblWindX=menuWind.addLabel("Wind: ");
  windMi=menuWind.addButton("Wind-",new GUIPrintEvent("Wind-"));
  windPl=menuWind.addButton("Wind+",new GUIPrintEvent("Wind+"));
  //gravXMI=menuGrav.addButton("GravX-",new GUIPrintEvent("GravX-"));
  //gravXPL=menuGrav.addButton("GravX+",new GUIPrintEvent("GravX+"));
  
  menuUI.expandMenus();
}
void updateGUI(){
}
void displayGUI(){
  menuUI.display();
}