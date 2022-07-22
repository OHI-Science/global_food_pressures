Flow:
1. Everything starts and ends with the "farm" scripts. These prepare the MapSPAM data and finalize the stressors for each crop.
2. The 4 pressures end up saving final stressor file for each crop on aurora: farm/stressors
3. The farm/step7_super_cats then takes the farm/stressor data and combines it into our SPAM super categories and saves in the aurora: datalayers folder
(which is what is accessed in the _analysis scripts)
4. There are a lot of linkages between the crop stressors:
So: if updating the water or nutrient data, you will also need to run the ghg calculations again. 
- The water folder contains a script that provides irrigation data used in the ghg calculations
- The nutrient data is also used in the ghg calculations

The grazed land nutrient application is ultimately used to calculate animal product stressors.
