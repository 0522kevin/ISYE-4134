/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Jan 25, 2024 at 4:04:04 PM
 *********************************************/
 using CP;
 
 // String arrays given in the problem. Each value in each array will be assigned to one house
 {string} Jobs = {"painter", "diplomat", "violinist", "doctor", "sculptor"};
 {string} Animals = {"dog", "zebra", "fox", "snail", "horse"};
 {string} Drinks = {"juice", "water", "tea", "coffee", "milk"};
 
 // Additionally declared string arrays. Each value in each array will be assigned to one house
 {string} Color = {"red", "green", "white", "yellow", "blue"};
 {string} Nationality = {"English", "Spaniard", "Japanese", "Italian", "Norwegian"};
 
 // Decision variables given in the problem. Each value represents a house
 // 0 is the leftmost house and 4 is the rightmost house
 dvar int jobHouse[Jobs] in 0..4;
 dvar int animalHouse[Animals] in 0..4;
 dvar int drinkHouse[Drinks] in 0..4;
 
 // Additionally declared decision variables. Each value represents a house
 // 0 is the leftmost house and 4 is the rightmost house
 dvar int colorHouse[Color] in 0..4;
 dvar int nationalityHouse[Nationality] in 0..4;
 
 constraints {
   
   // Two houses cannot have the same job
   forall(ordered a, b in Jobs)
     jobHouse[a] != jobHouse[b];
     
   // Two houses cannot have the same favorite animal
   forall(ordered c, d in Animals)
     animalHouse[c] != animalHouse[d];
     
   // Two houses cannot drink the same drinks
   forall(ordered e, f in Drinks)
     drinkHouse[e] != drinkHouse[f];
     
   // Two houses cannot have the same color
   forall(ordered g, h in Color)
     colorHouse[g] != colorHouse[h];
     
   // Two houses cannot have the same nationality
   forall(ordered i, j in Nationality)
     nationalityHouse[i] != nationalityHouse[j];

   // 1. The English person lived in the red house
   nationalityHouse["English"] == colorHouse["red"];
   
   // 2. The spaniard owned the dog
   nationalityHouse["Spaniard"] == animalHouse["dog"];
   
   // 3. The Japanese was a painter
   nationalityHouse["Japanese"] == jobHouse["painter"];
   
   // 4. The Italian drank tea
   nationalityHouse["Italian"] == drinkHouse["tea"];
    
   // 5. The Norwegian lived in the first house on the left
   nationalityHouse["Norwegian"] == 0;
   
   // 6. The owner of the green house drank coffee
   colorHouse["green"] == drinkHouse["coffee"];
   
   // 7. The green house was on the right of the white one
   colorHouse["green"] == colorHouse["white"] + 1;
   
   // 8. The sculptor was breeding snails
   jobHouse["sculptor"] == animalHouse["snail"];
   
   // 9. The diplomat lived in the yellow house
   jobHouse["diplomat"] == colorHouse["yellow"];
   
   // 10. Milk was drunk in the middle house
   drinkHouse["milk"] == 2;
   
   // 11. The Norwegian lived next to the blue house
   (nationalityHouse["Norwegian"] - colorHouse["blue"] == 1) || (colorHouse["blue"] - nationalityHouse["Norwegian"] == 1);
   
   // 12. The violinist drank fruit juice
   jobHouse["violinist"] == drinkHouse["juice"];
   
   // 13. The fox was in the house next to that of the doctor
   (animalHouse["fox"] - jobHouse["doctor"] == 1) || (jobHouse["doctor"] - animalHouse["fox"] == 1);
   
   // 14. The horse was in the house next to that of the diplomat
   (animalHouse["horse"] - jobHouse["diplomat"] == 1) || (jobHouse["diplomat"] - animalHouse["horse"] == 1);
   
 }