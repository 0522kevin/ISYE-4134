/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Mar 26, 2024 at 12:02:00 AM
 *********************************************/
 
 using CP;
 
 // given data declarations
 int nbStations = ...;
 range Stations = 1..nbStations;
 tuple stationData {
   int service;
   int start;
   int end;
 };
 
 stationData data[Stations] = ...;
 int time[Stations, Stations] = ...;
 
 tuple Precedence { int after; int before; };
 {Precedence} Precedences = ...;
 
 // tuple that grabs time array for noOverlap function
 tuple triplet { int loc1; int loc2; int value; };
 {triplet} times = {<i, j, time[i, j]> | i in Stations, j in Stations}; 
 
 // interval that has the size of service time of each station
 dvar interval service[s in Stations] size data[s].service;
 // sequence that orders the station
 dvar sequence seq in all(s in Stations) service[s] types all(s in Stations) s;
 // R2D2's travel time
 dvar int travel;
 
 // objective function that minimizes R2D2's travel time
 minimize travel;
 
 constraints {
   
   // R2D2 cannot work on two stations at the same time
   noOverlap(seq, times);
   
   // Enforces the constraint of some stations being worked on before others
   forall(p in Precedences) startOf(service[p.after]) >= endOf(service[p.before]) + time[p.before, p.after];
   
   // Enforces the start time of each service to be within the allowed window
   forall(s in Stations) startOf(service[s]) >= data[s].start;
   forall(s in Stations) startOf(service[s]) <= data[s].end;
   
   // sums up the travel time of R2D2
   travel == sum(s in Stations) time[s, typeOfNext(seq, service[s], 22)];
  
 }
 
 // the visits of R2D2 and specifies the station visited after s. if s is the last station, then nextStation[s] = 1
 int nextStation[s in Stations] = typeOfNext(seq, service[s], 1);
 
 // describes the time at which R2D2 visits station s and start service
 int serviceTime[s in Stations] = startOf(service[s]);
 
 execute {
   writeln("nextStation: " + nextStation);
   writeln("serviceTime: " + serviceTime);
 }