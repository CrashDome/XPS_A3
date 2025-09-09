#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_Method
	<TypeDefinition>
		---prototype
		XPS_AP_typ_Method : XPS_AP_ifc_IMethod
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_AP_typ_Method"]
    	---

Authors: 
	Crashdome

Description:
	A Method is a collection used in Heirarchical Task/Goal-Task Networks which decompose 
	into smaller subtasks based on a satisfied condition. 

Returns:
	<HashmapObject> of a Method

---------------------------------------------------------------------------- */
[
	["#type","XPS_AP_typ_Method"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Method"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IMethod>
	-----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_AP_ifc_IMethod"]],
	/*----------------------------------------------------------------------------
	Method: Decompose
    
    	--- Prototype --- 
    	call ["Decompose",[_context, _args*]]
    	---

		<XPS_AP_ifc_IMethod>
    
	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

    Optionals: 
        _args* - (Optional) - <Anything> - arguments passed to condition when executed

    Returns: 
		<Array> - of <XPS_AP_ifc_INodes> or nil if failure

	-----------------------------------------------------------------------------*/
    ["Decompose", {}]
]