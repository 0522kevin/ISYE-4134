/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Jan 30, 2024 at 6:38:02 PM
 *********************************************/
 
 using CP;
 
 // Data given in the problem
 int nbPeriods= ...;
 int minCourses= ...; /* minimum amount of courses necessary per period */
 int maxCourses= ...; /* maximum amount of courses allowed per period */
 int minUnit= ...; /* minimum number of units units necessary per period */
 int maxUnit= ...; /* maximum number of units allowed per period */

 {string} Courses = ...;

 int unit[Courses] = ...;

 tuple prec {
   string before;
   string after;
 }
 
 {prec} Prerequisites = ...;
 
 range Periods = 1..nbPeriods;
 
 // Decision variable that assigns each course to a period
 dvar int period[Courses] in Periods;
 
 constraints {
   
   // An apprentice must take a minimum number of courses and cannot exceed a maximum number of courses during each period
   // First constraint sets the minimum number of courses for each period, second sets the maximum number of courses for each period
   forall(p in Periods)
     sum(c in Courses) (period[c] == p) >= minCourses;
   forall(p in Periods)
     sum(c in Courses) (period[c] == p) <= maxCourses;
     
   // An apprentice must take a minimum number of units and cannot exceed a maximum number of units during each period
   // First constraint sets the minimum number of units for each period, second sets the maximum number of units for each period
   forall(p in Periods)
     sum(c in Courses) (period[c] == p)*unit[c] >= minUnit;
   forall(p in Periods)
     sum(c in Courses) (period[c] == p)*unit[c] <= maxUnit;
     
   // An apprentice cannot take more courses in period i than in period i + 1
   // Sums up all the courses for i and i + 1, then sets the inequality constraint 
   forall(i in 1..nbPeriods-1)
     sum(c in Courses)(period[c] == i) <= sum(c in Courses)(period[c] == i + 1);

   // Prerequisites must be met. Second course within each must be taken after the first course
   // Iterates through all prerequisites, and sets the period for before-courses and after-courses to the correct inequality
   forall(p in Prerequisites)
     period[p.before] < period[p.after];
   
 }