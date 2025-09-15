#include "script_component.hpp"

class CfgMods {
    class ADDON {
        name = "XPS Formation AI";
        dir = COMPONENT_DIR;
        author = "XPS Group";
        description = "Extensible Project System - FormationAI";
        overview = "Work In Progress";
    };
};

class CfgPatches {
	class ADDON {
			// Meta information for editor
			name = "XPS : Formation AI";
			author = "XPS Group";
			url = "";
	
			requiredVersion = REQUIRED_VERSION; 
			requiredAddons[] = { "xps_main", "xps_core", "xps_bt", "xps_ap" };
			units[] = {};
			weapons[] = {};
			//skipWhenMissingDependencies = 1;
	};
};

//#include "CfgTypeDefinitions.hpp"
#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"
//#include "Cfg3DEN.hpp"