# Point sampling

The voronoi function is taken from VoronoiNoise2.pde
This just jitters points until a certain "non-clustered" condition is met.
The points are non-clustered when each point is more than 50 pixels away from each other point.
Once the points satisfy the non-cluster condition, the voronoi diagram is drawn
to vizualize the seperation.
Press the mouse to generate a new set of points.
It also draws lines between point less than 2*dist pixels away from eachother to visualize the clustering amount.
