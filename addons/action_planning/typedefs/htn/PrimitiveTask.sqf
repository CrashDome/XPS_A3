#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_PrimitiveTask
	<TypeDefinition>
		---prototype
		XPS_AP_typ_PrimitiveTask : XPS_AP_ifc_INode, XPS_AP_ifc_IPrimitiveTask
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_AP_typ_PrimitiveTask"]
    	---

Authors: 
	Crashdome

Description:
	An HTN Node which contains a single action <XPS_AP_typ_Operator>.

Returns:
	<HashmapObject> of a Method

---------------------------------------------------------------------------- */
[
	["#type","XPS_AP_typ_PrimitiveTask"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_PrimitiveTask"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IPrimitiveTask>
	-----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_AP_ifc_IPrimitiveTask"]],
	/*----------------------------------------------------------------------------
	Method: GetOperator
    
    	--- Prototype --- 
    	call ["Operation",_args*]
    	---

		<XPS_AP_ifc_IPrimitiveTask>

	Description:
		Retrieves a clone of the underlying operator and optionally sets it's parameters.

    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to Operation when executed

    Returns: 
		<Anything>

	-----------------------------------------------------------------------------*/
    ["GetOperator", {}],
	/*----------------------------------------------------------------------------
	Method: Effects
    
    	--- Prototype --- 
    	call ["Effects",_args*]
    	---

        Alternative: 

        --- code ---
        get "Effects"  //allows lazy execution
        ---

		<XPS_AP_ifc_IPrimitiveTask>

	Description:
		Code to execute on current World State after Operation has completed.

    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to Effects when executed

    Returns: 
		<Anything>

	-----------------------------------------------------------------------------*/
    ["Effects", {}],
	/*----------------------------------------------------------------------------
	Method: Expected
    
    	--- Prototype --- 
    	call ["Expected",_args*]
    	---

        Alternative: 

        --- code ---
        get "Expected"  //allows lazy execution
        ---

		<XPS_AP_ifc_IPrimitiveTask>

	Description:
		Code to execute on the working world state during planning. Applies expected changes
		in order to validate possible future tasks.

    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to Expected when executed

    Returns: 
		<Anything>

	-----------------------------------------------------------------------------*/
    ["Expected", {}]
]