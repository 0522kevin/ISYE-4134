/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Mar 6, 2024 at 11:51:57 AM
 *********************************************/
 
 using CP;
 
 execute {
   // cp.param.AllDiffInferenceLevel = 6;
   // cp.param.SearchType = "DepthFirst";
 }

 // given variables
 int n = 11;
 int bound = ftoi(round(exp(n)));
 range N = 1..n;
 range D = 0..bound;
 
 // decision variable
 dvar int p[N] in D;
 
 // another decision variable not mentioned in problem
 // denotes the distance between unit i and j
 // min possible distance is 0, and max possible distance is bound
 dvar int dist[i in N, j in N] in D;
 
 execute {
   // var f = cp.factory;
   // cp.setSearchPhases(f.searchPhase(dist), f.searchPhase(p));
 }

 // minimize the distance between the first unit and the last unit
 minimize dist[1, n];
 
 constraints { 
   
   // input distance values into dist array
   forall(ordered i, j in N) dist[i, j] == p[j] - p[i];
   // forall(i, j in N) dist[i, j] == abs(p[j] - p[i]);
   
   // distance between all pairs of units are different
   allDifferent(all(ordered i, j in N) dist[i, j]);
   
   // logic that follows after ordering units
   // distance between i and k is equal to the summation of i, j and j, k
   forall(ordered i, j, k in N) dist[i, j] + dist[j, k] == dist[i, k];
   
   // forces starting positions of 1
   p[1] == 0;

   // orders the p array        
   forall(i in 1..n-1) p[i] < p[i+1];
   
   // reduces the search space by limiting the options for dist array
   forall(i in 1..n-1) dist[i, i] + dist[i+1, i+1] >= dist[i, i+1];
     
   

 }