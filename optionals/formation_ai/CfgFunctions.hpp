class CfgFunctions {
	class ADDON {
		class Init {
			class preInit {
				file = XPS_FILEPATH_C_STR(preInit.sqf);
				preInit = 1;
			};
		};
		class General {
			XPS_CFG_FNC(getFormationDestination);
			XPS_CFG_FNC(getFormationDistance);
			XPS_CFG_FNC(getFormationDistanceThreshold);
			XPS_CFG_FNC(getFormationMoveTo);
			XPS_CFG_FNC(getFormationPosition);
		};
	};
};
