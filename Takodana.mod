/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Mar 12, 2024 at 12:06:28 AM
 *********************************************/
 
 using CP;
 
 // given variable declarations
 {string} Tasks = ...;
 int nbHouses = ...;
 range Houses = 1..nbHouses;
 int duration[Tasks] = ...;
 int releaseDate[Houses] = ...;
 tuple Prec { string before; string after; };
 {Prec} Precedences = ...;
 tuple Deadline { string t; int date; float cost; };
 {Deadline} Earliness = ...;
 {Deadline} Tardiness = ...;
 int maxEarlinessCost = ...;
 
 // expected output array
 int startDate[Houses, Tasks];
 
 // decision intervals for each house
 dvar interval task1[t in Tasks] size duration[t];
 dvar interval task2[t in Tasks] size duration[t];
 dvar interval task3[t in Tasks] size duration[t];
 
 // minimizes the sum of tardiness cost 
 minimize 
   sum(t in Tardiness) t.cost * maxl(0, endOf(task1[t.t]) - t.date) +
   sum(t in Tardiness) t.cost * maxl(0, endOf(task2[t.t]) - t.date) +
   sum(t in Tardiness) t.cost * maxl(0, endOf(task3[t.t]) - t.date);

 constraints {
   
   // enforces the order of tasks for each house
   forall(p in Precedences)
     endBeforeStart(task1[p.before], task1[p.after]);
   forall(p in Precedences)
     endBeforeStart(task2[p.before], task2[p.after]);
   forall(p in Precedences)
     endBeforeStart(task3[p.before], task3[p.after]);
   
   // sum of earliness costs for all houses do not exceed the value maxEarlinessCost
   sum(e in Earliness) e.cost * maxl(0, e.date - startOf(task1[e.t])) +
   sum(e in Earliness) e.cost * maxl(0, e.date - startOf(task2[e.t])) +
   sum(e in Earliness) e.cost * maxl(0, e.date - startOf(task3[e.t])) 
   <= maxEarlinessCost;
  
  // each house cannot be worked on before its release date of materials
  startOf(task1["masonry"]) >= releaseDate[1];
  startOf(task2["masonry"]) >= releaseDate[2];
  startOf(task3["masonry"]) >= releaseDate[3];
 }
 
 // prints out the expected output array
 execute {
   for(var t in Tasks) {
     startDate[1][t] = task1[t].start;
     startDate[2][t] = task2[t].start;
     startDate[3][t] = task3[t].start;
   }
   
   writeln(startDate);  
 }