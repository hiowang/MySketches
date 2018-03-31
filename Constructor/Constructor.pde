//TODO for 3-0-0: have all features implemented BEFORE json is implemented


//1-0-0   add edges,points,fixed,remove points,save/open
//2-0-0   add muscles smoothCos and jerkyCos
//2-0-1   add more controls, info, ability to rem edges
//2-0-2   add ability to cycle through "isMuscle" and "muscleType"
//3-0-0   complete redesign
//3-1-0   add ability to save/open to/from files
final String versionNumber="3-0-1";
final String versionNumberFormatted=versionNumber.replaceAll("-",".");
String workspaceFile="~/Documents/Constructions/";
String currentFile=workspaceFile+"Untitled.constr"+versionNumber;//Replace with your preferred directory
PFont fontNormal;
PFont fontBold;
PFont fontLarge;
//PFont fontItalic;
//PFont fontUnderlined;

void fileSelectedInput(File selection){
  isSimulating=false;
  if(selection==null){
  }else{
    currentFile=selection.getAbsolutePath();
    fromJSON(loadJSONObject(selection.getAbsolutePath()));
  }
}
void fileSelectedOutput(File selection){
  isSimulating=false;
  if(selection==null){
  }else{
    saveJSONObject(toJSON(),selection.getAbsolutePath());
    currentFile=selection.getAbsolutePath();
  }
}


JSONObject toJSON(){
  JSONObject obj=new JSONObject();
  JSONArray arrPoints=new JSONArray();
  for(Point p:points){
    arrPoints.append(pointToJSON(p));
  }
  obj.setJSONArray("arrPoints",arrPoints);
  JSONArray arrEdges=new JSONArray();
  for(Edge e:edges){
    arrEdges.append(edgeToJSON(e));
  }
  obj.setJSONArray("arrEdges",arrEdges);
  obj.setFloat("gravity",gravity);
  return obj;
}

void fromJSON(JSONObject obj){
  points=new ArrayList<Point>();
  JSONArray arrPoints=obj.getJSONArray("arrPoints");
  for(int i=0;i<arrPoints.size();i++){
    points.add(pointFromJSON(arrPoints.getJSONObject(i)));
  }
  edges=new ArrayList<Edge>();
  JSONArray arrEdges=obj.getJSONArray("arrEdges");
  for(int i=0;i<arrEdges.size();i++){
    edges.add(edgeFromJSON(arrEdges.getJSONObject(i)));
  }
}

void setup() {
  size(750, 750);
  //println(map(PointMassDef,PointMassMi,PointMassMa,PointSizeMi,PointSizeMa));
  
  points=new ArrayList<Point>();
  edges=new ArrayList<Edge>();
  gravity=defGravity;
  
  //Point a=new Point(100,0);
  //Point b=new Point(650,375);
  //Edge e=new Edge(EdgeType.Normal,a,b,100);
  //points.add(a);
  //points.add(b);
  //edges.add(e);
  
  println("Constructor V"+versionNumberFormatted);
  fontNormal=loadFont("Monospaced-10-normal.vlw");
  fontBold=loadFont("Monospaced-15-normal.vlw");
  fontLarge=loadFont("Monospaced-30-normal.vlw");
  textFont(fontNormal);
}