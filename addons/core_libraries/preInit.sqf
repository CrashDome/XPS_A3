#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: core. XPS_Core

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS Core preInit]";

// Singleton Class Instantiations ------------------------------------------

// Static Class Instantiations --------------------------------------------
/* -------------------------------------------------------------------------
Variable: core. XPS_Enum
	<Static>

Description:
	Used to compare and inspect <Enumeration> Types.

	See <XPS_typ_Enum> for more info on operations.

Returns: 
	<Static> - of <XPS_typ_Enum>
---------------------------------------------------------------------------*/
XPS_Enum = compileFinal createHashmapObject [XPS_typ_Enum];

/* -------------------------------------------------------------------------
Variable: core. XPS_LifeTime

Description:
	A Helper class for an <Enumeration> set

	- <XPS_LifeTime_Transient> 
	- <XPS_LifeTime_Scoped> 
	- <XPS_LifeTime_Singleton> 

Returns: 
	<HashmapObject> - of type <XPS_enum_LifeTime>
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: core. XPS_LifeTime_Transient 
	<Enumeration> 

Keys: 
	#str - "Transient"
	Value - "0"
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: core. XPS_LifeTime_Scoped
	<Enumeration> 

Keys: 
	#str - "Scoped"
	Value - "1"
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: core. XPS_LifeTime_Singleton 
	<Enumeration> 

Keys: 
	#str - "Singleton"
	Value - "2"
---------------------------------------------------------------------------*/
["XPS_LifeTime",XPS_enum_LifeTime] call XPS_fnc_createEnumeration;

/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT_Status

Description:
	A Helper class for an <Enumeration> set

	- <XPS_Status_Success> 
	- <XPS_Status_Failure> 
	- <XPS_Status_Running> 

Returns: 
	<HashmapObject> - of type <XPS_enum_Status>
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_Status_Success 
	<Enumeration> 

Keys: 
	#str - "Success"
	Value - "SUCCESS"
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_Status_Failure
	<Enumeration> 

Keys: 
	#str - "Failure"
	Value - "FAILURE"
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_Status_Running 
	<Enumeration> 

Keys: 
	#str - "Running"
	Value - "RUNNING"
---------------------------------------------------------------------------*/
["XPS_BT_Status",XPS_enum_Status] call XPS_fnc_createEnumeration;

diag_log text "[XPS Core preInit End]";

ADDON = true;