/*********************************************
 * OPL 20.1.0.0 Model
 * Author: kahn41
 * Creation Date: Jan 18, 2024 at 3:17:10 PM
 *********************************************/
using CP;

// The Four Color Theorem states that maps color code countries differently if the countries are adjacent states that 
// only 4 colors are needed to completely color a map with such rule
range Colors = 0..3;

// Planets come from the galaxy.dat file
{string} Planets = ...;

// The decision variable color for each planets comes from the range Colors
dvar int color[Planets] in Colors;

constraints {
  // Dagobag is adjacent to these countries
  color["Dagobah"] != color["Geonosis"];
  color["Dagobah"] != color["Kamino"];
  color["Dagobah"] != color["Adleraan"];
  color["Dagobah"] != color["Dantooine"];
  color["Dagobah"] != color["Coruscant"];
  color["Dagobah"] != color["Endor"];
  color["Dagobah"] != color["Nur"];
  
  // Naboo is adjacent to these countries
  color["Naboo"] != color["Kamino"];
  color["Naboo"] != color["Takodana"];
  color["Naboo"] != color["Onderon"];
  color["Naboo"] != color["Cantonica"];
  color["Naboo"] != color["Coruscant"];
  
  // Geonosis is adjacent to these countries
  color["Geonosis"] != color["Kamino"];
  color["Geonosis"] != color["Onderon"];
  color["Geonosis"] != color["Endor"];
  color["Geonosis"] != color["Nur"];
  color["Geonosis"] != color["Takodana"];
  color["Geonosis"] != color["Dantooine"];
  
  // Kamino is adjacent to these countries
  color["Kamino"] != color["Dantooine"];
  color["Kamino"] != color["Takodana"];
  color["Kamino"] != color["Onderon"];
  color["Kamino"] != color["Endor"];
  color["Kamino"] != color["Cantonica"];
  color["Kamino"] != color["Adleraan"];
  
  // Coruscant is adjacent to these countries
  color["Coruscant"] != color["Cantonica"];
  color["Coruscant"] != color["Endor"];
  color["Coruscant"] != color["Nur"];
  color["Coruscant"] != color["Takodana"];
  
  // Endor is adjacent to these countries
  color["Endor"] != color["Nur"];
  color["Endor"] != color["Takodana"];
  
  // Nur is adjacent to these countries
  color["Nur"] != color["Onderon"];
  color["Nur"] != color["Takodana"];
}