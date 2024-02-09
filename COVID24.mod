/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Feb 5, 2024 at 6:54:50 PM
 *********************************************/
 
 using CP;
 
 // variable declarations given in the problem
 int nbResidents = ...;
 int minPatients = ...;
 int maxPatients = ...;
 int minLoad = ...;
 int maxLoad = ...;
 range Residents = 1..nbResidents;
 int nbPatients = ...;
 range Patients = 1..nbPatients;	
 
 tuple PatientData {
   int load;
   int zone;
 }
 
 PatientData patientData[Patients] = ...;
 
 
// added variables
// calculates the number of zones in the .dat file
 int numZone = max(p in Patients) patientData[p].zone;
 range Zones = 1..numZone;
 
 // expected output of the problem
 {int} residentPatients[Residents];
 
 // decision variable that assigns a resident to each patient
 dvar int patientsResident[Patients] in Residents;
 
 // decision variable that assigns a resident to a zone
 dvar int residentsZone[Residents] in Zones;
 
 // objective function that minimizes the maximum load across all residents in zone 1
 minimize
 	max(r in Residents)
 		sum(p in Patients) (patientsResident[p] == r && residentsZone[r] == 1) * patientData[p].load;
 
 constraints {
   
   // each resident is assigned to at least minPatients and at most maxPatients
   forall(r in Residents)
     sum(p in Patients) (patientsResident[p] == r) >= minPatients;
   forall(r in Residents)
     sum(p in Patients) (patientsResident[p] == r) <= maxPatients;
   
   // each resident cannot have a load that exceeds maxLoad; the resident should also have a load that is at least minLoad
   forall(r in Residents)
     sum(p in Patients) (patientsResident[p] == r) * patientData[p].load >= minLoad;
   forall(r in Residents)
     sum(p in Patients) (patientsResident[p] == r) * patientData[p].load <= maxLoad;
   
   // each resident can work only in one zone
   // for each resident r, sums up the number of patients where patient p is assigned to r AND p and r are in different zones
   // the sum has to be 0
   forall(r in Residents)
     sum(p in Patients) (patientsResident[p] == r && patientData[p].zone != residentsZone[r]) == 0;
 }

 // prints the extected output array 
 execute {
   for(var p in Patients) {
     var r = patientsResident[p];
     residentPatients[r].add(p);
   }
   writeln(residentPatients);   
 }