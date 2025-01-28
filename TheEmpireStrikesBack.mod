/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Feb 19, 2024 at 4:37:07 PM
 *********************************************/
 
 using CP;
 
 execute {
   cp.param.AllDiffInferenceLevel = 6;
   cp.param.SearchType = "DepthFirst";
 }
 
 // given variables
 int nbSites = ...;
 int nbFighters = ...;
 int capacity[1..nbFighters] = ...;
 range Sites = 0..nbSites-1;
 tuple Site {
   int demand;
   int x;
   int y;
 };
 Site siteData[Sites] = ...;
 
 int nbLocations = nbFighters + nbSites - 1;
 range Locations = 1..nbLocations;
 range Depots = 1..nbFighters;
 range Customers = (nbFighters + 1)..nbLocations;
 
 Site data[l in Locations] = (l <= nbFighters) ? siteData[0] : siteData[l-nbFighters];
 
 int dist[i in Locations,j in Locations] = ftoi(round(sqrt((data[i].x - data[j].x)^2 + (data[i].y - data[j].y)^2)));
 
 // decision variables
 
 // next notes the next location the jet is going after being in location l, opposite for prev
 // seq is used to establish next as a Hamiltonian cycle
 dvar int next[Locations] in Locations;
 dvar int pred[Locations] in Locations;
 dvar int seq[Locations] in Locations;
 
 // jet marks which fighter visits which location
 dvar int jet[Locations] in Depots;
 
 execute {
   var f = cp.factory;
   cp.setSearchPhases(f.searchPhase(jet), f.searchPhase(next));
 }
 
 // minimize the time at which the latest planet gets its relief
 // that means to calculate the max distance fighters takes until the last planet then minimize 
 minimize
   max(d in Depots)
     sum(c in Customers) (jet[c] == d)*dist[c, pred[c]];

 constraints {
   
   // establish a Hamiltonian cycle 
   seq[1] == next[1];
   seq[nbLocations] == 1;
   forall(l in 2..nbLocations)
     seq[l] == next[seq[l - 1]];
     
   allDifferent(next);
   allDifferent(seq);
   
   forall(l in 1..nbLocations)
     pred[next[l]] == l;
   
   // stops the jet from staying in one location
   forall(l in Locations)
     next[l] != l;
   
   // marks each fighter jets to each depot
   forall(d in Depots)
     jet[d] == d;
   
   // fighters have a fixed storage capacity
   // sums up the demands each fighter jets goes to, and makes sure the capacity is less or equal        
   forall(d in Depots)
     sum(c in Customers) (jet[c] == d) * data[c].demand <= capacity[d];  
    
   // fighter jet constraint
   // makes sure the jets are the same with the previous destination 
   forall(c in Customers)
     jet[c] == jet[next[c]];

   
}
