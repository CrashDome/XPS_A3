#include "script_component.hpp"

class CfgMods {
    class ADDON {
        name = "XPS Map Grids";
        dir = COMPONENT_DIR;
        author = "Crashdome";
        description = "Extensible Project System - Map Grids";
        overview = "Work In Progress";
    };
};

class CfgPatches {
	class ADDON {
			// Meta information for editor
			name = "XPS : Map Grids";
			author = "Crashdome";
			url = "";
	
			// Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
			requiredVersion = REQUIRED_VERSION; 
			// Required addons, used for setting load order.
			// When any of the addons is missing, pop-up warning will appear when launching the game.
			requiredAddons[] = { "xps_main" ,"xps_core" };
			// List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups) unlocking.
			units[] = {};
			// List of weapons (CfgWeapons classes) contained in the addon.
			weapons[] = {};
	};
};

#include "Cfg3DEN.hpp"
#include "CfgFunctions.hpp"
#include "CfgTypeDefinitions.hpp"