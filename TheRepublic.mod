/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Feb 1, 2024 at 8:44:25 PM
 *********************************************/
 
 using CP;
 
 // variables given in the problem
 int nbControlCenters = ...;
 range ControlCenters = 0..nbControlCenters-1;
 
 int nbLocations = ...;
 range Locations = 0..nbLocations-1;
 
 int nbTogether = ...;
 range RTogether = 1..nbTogether;
 {int} Together[RTogether] = ...;
 
 int nbSeparated = ...;
 range RSeparated = 1..nbSeparated;
 {int} Separated[RSeparated] = ...;
 
 int f[ControlCenters,ControlCenters] = ...;
 int hop[Locations,Locations] = ...;
 int M = ...;
 
 // decision variable
 // marks the location of each control centers
 dvar int location[ControlCenters] in Locations;
 
 // objective function
 // minimize the maximum communication cost between the control centers
 // communication cost = f^2 * h
 minimize
 	max(ordered a, b in ControlCenters)
 		(f[a, b])^2 * hop[location[a], location[b]];
 
 constraints {
   
   // for every tuple in Separated, the control centers in the tuples cannot be in the same location
   forall(r in RTogether)
     forall(ordered x, y in Together[r])
       location[x] == location[y];
   
   // for every tuple in Together, the control centers in the tuples have to be in the same location
   forall(r in RSeparated)
     forall(ordered x, y in Separated[r])
       location[x] != location[y];
       
   // each location has a maximum number of control centers 
   forall(l in Locations)
     sum(c in ControlCenters) (location[c] == l) <= M;
     
 }