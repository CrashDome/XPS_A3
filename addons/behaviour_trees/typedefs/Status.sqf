#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_enum_Status
	<TypeDefinition>
		---prototype
		XPS_enum_Status : XPS_ifc_IEnumeration, XPS_typ_Enumeration
		---

Authors: 
	Crashdome

Description:
	An Enumeration set for node statuses.

	--- code
	XPS_Status_Success	Success		SUCCESS
	XPS_Status_Failure	Failure		FAILURE
	XPS_Status_Running	Running		RUNNING
	---

	See <XPS_fnc_createEnumeration:core. typeHandlers. XPS_fnc_createEnumeration> for more info on usage of types inheriting this type

---------------------------------------------------------------------------- */
[
	["#type","XPS_enum_Status"],
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
		<XPS_typ_Enumeration.Values>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: GetEnum
		<XPS_typ_Enumeration.GetEnum>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: IsDefined
		<XPS_typ_Enumeration.IsDefined>
	-----------------------------------------------------------------------------*/
]
