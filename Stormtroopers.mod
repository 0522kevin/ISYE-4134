/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Jan 25, 2024 at 11:37:35 PM
 *********************************************/

 using CP;
 
 // Variables given in the problem
 int n = ...;
 range legions = 1..n;
 dvar int sites[legions] in 0..n-1;
 
 // Additional variables declared
 // Records the distance between two legions
 range legionDistance = 1..n-1;
 dvar int siteDistance[legionDistance] in 1..n-1;
 
 constraints {
   
   // Only one legion can occupy one site
   forall(ordered x, y in legions)
     sites[x] != sites[y];
     
   // Inputs absolute value of the distance between consecutive legions 
   forall(i in 1..n-1)
     siteDistance[i] == abs(sites[i + 1] - sites[i]);
     
   // Each distance between legions must be distinct
   forall(ordered a, b in legionDistance)
     siteDistance[a] != siteDistance[b];
 
 }