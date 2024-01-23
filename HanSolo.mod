/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Jan 19, 2024 at 5:28:11 PM
 *********************************************/

 using CP;
 
 // The letters Han Solo adds up in the problem
 {string} Letters = {"D", "O", "N", "A", "L", "G", "E", "R", "B", "T"};
 
 // Letters can have values from 0 to 9, with the exception of first D, G, R due to the words starting with those letters
 dvar int v[Letters] in 0..9;
 
 // Five carry-on values. These carry-on values can either be 0 or 1
 dvar int c[1..5] in 0..1;
 
 constraints {
   // Multiple letters cannot have the same value
   forall(ordered i, j in Letters)
     v[i] != v[j];
   
   // Letters that start the words: Donald, Gerald, and Robert cannot have 0 as its first number
   v["D"] != 0;
   v["G"] != 0;
   v["R"] != 0;
   
   // For each column of the equation, both sides of the equation (separated by the horizontal line)
   // should be equal including the carry-on value (that comes down from the left column)
   c[5] + v["D"] + v["G"] == v["R"];
   c[4] + v["O"] + v["E"] == v["O"] + 10*c[5];
   c[3] + v["N"] + v["R"] == v["B"] + 10*c[4];
   c[2] + 2*v["A"] == v["E"] + 10*c[3];
   c[1] + 2*v["L"] == v["R"] + 10*c[2];
   2*v["D"] == v["T"] + 10*c[1];
 }