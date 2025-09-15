#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: unit_testing. XPS_UT

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS F preInit]";

diag_log text "[XPS F preInit End]";

ADDON = true;