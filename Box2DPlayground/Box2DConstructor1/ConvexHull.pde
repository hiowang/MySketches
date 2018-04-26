public int orientation(PVector p, PVector q, PVector r)
{
  float val = (q.y - p.y) * (r.x - q.x) -
    (q.x - p.x) * (r.y - q.y);

  if (val == 0) return 0;  // collinear
  return (val > 0)? 1: 2; // clock or counterclock wise
}

// Prints convex hull of a set of n PVectors.
public ArrayList<PVector> convexHull(ArrayList<PVector>PVectors)
{
  int n=PVectors.size();
  // There must be at least 3 PVectors
  if (n < 3) return new ArrayList<PVector>();

  // Initialize Result
  ArrayList<PVector> hull = new ArrayList<PVector>();

  // Find the leftmost PVector
  int l = 0;
  for (int i = 1; i < n; i++)
    if (PVectors.get(i).x < PVectors.get(l).x)
      l = i;

  // Start from leftmost PVector, keep moving 
  // counterclockwise until reach the start PVector
  // again. This loop runs O(h) times where h is
  // number of PVectors in result or output.
  int p = l, q;
  do
  {
    // Add current PVector to result
    hull.add(PVectors.get(p));

    // Search for a PVector 'q' such that 
    // orientation(p, x, q) is counterclockwise 
    // for all PVectors 'x'. The idea is to keep 
    // track of last visited most counterclock-
    // wise PVector in q. If any PVector 'i' is more 
    // counterclock-wise than q, then update q.
    q = (p + 1) % n;

    for (int i = 0; i < n; i++)
    {
      // If i is more counterclockwise than 
      // current q, then update q
      if (orientation(PVectors.get(p), PVectors.get(i), PVectors.get(q))
        == 2)
        q = i;
    }

    // Now q is the most counterclockwise with
    // respect to p. Set p as q for next iteration, 
    // so that q is added to result 'hull'
    p = q;
  } 
  while (p != l);  // While we don't come to first 
  // PVector

  // Print Result
  return hull;
  //for (PVector temp : hull)
  //System.out.println("(" + temp.x + ", " +
  //temp.y + ")");
}