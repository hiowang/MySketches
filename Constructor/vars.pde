VarMode varMode=null;

ArrayList<Point> points;
ArrayList<Edge> edges;

Point pointSelectedForEdge;

float gravity;
boolean isSimulating=false;

final color pointSelectedForEdgeColor=color(100,100,200,100);
final color pointHoverColor=color(200,100,100,100);
final color edgeHoverColor=color(100,200,100,100);

final static float PointSelectSize=20;
final static float EdgeSelectSize=20;
final static float EdgeHandleSize=10;

final static float textDiff=15;
final static float minEdgeK=0;
final static float maxEdgeK=3;

final color colEdgeMuscleSmooth=color(100,200,100);
final color colEdgeMuscleJerky=color(200,100,100);
final color colTitle=color(100,100,200);

final static float floorHeight=100;

final static float minEdgeDist=50;
final static float maxEdgeDist=1000;

final static float defGravity=0.001;
final static float defFixedK=2;
final static float defUnFixedK=1;
final static float defMuscleK=1;

final static float PointSizeMi=5;
final static float PointSizeMa=15;

final static float PointMassMi=0;
final static float PointMassDef=60;
final static float PointMassMa=100;