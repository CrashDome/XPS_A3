#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_enum_Status
	<TypeDefinition>
		---prototype
		XPS_BT_enum_Status : core.XPS_ifc_IEnumeration, core.XPS_typ_Enumeration
		---

Authors: 
	Crashdome

Description:
	An Enumeration set for node statuses.

	--- code
	XPS_BT_Status_Success	Success		SUCCESS
	XPS_BT_Status_Failure	Failure		FAILURE
	XPS_BT_Status_Running	Running		RUNNING
	---

	See <core.XPS_fnc_createEnumeration> for more info on usage of types inheriting this type

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_enum_Status"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<core.XPS_typ_Enumeration>
	-----------------------------------------------------------------------------*/
	["#base",XPS_typ_Enumeration],
	/*----------------------------------------------------------------------------
	Property: Names
		<core.XPS_typ_Enumeration.Names>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: ValueType
    
    	--- Prototype --- 
    	get "ValueType"
    	---
    
    Returns: 
		<String> - "<STRING>"
	-----------------------------------------------------------------------------*/
	["ValueType","STRING"],
	["Enumerations", [["Success","SUCCESS"], ["Failure","FAILURE"], ["Running","RUNNING"]]]
	/*----------------------------------------------------------------------------
	Property: Values
		<core.XPS_typ_Enumeration.Values>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: GetEnum
		<core.XPS_typ_Enumeration.GetEnum>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: IsDefined
		<core.XPS_typ_Enumeration.IsDefined>
	-----------------------------------------------------------------------------*/
]