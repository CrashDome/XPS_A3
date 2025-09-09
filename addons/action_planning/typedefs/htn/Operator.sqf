#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_Operator
	<TypeDefinition>
		---prototype
		XPS_AP_typ_Operator : XPS_AP_ifc_IOperator, XPS_AP_ifc_INode
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_AP_typ_Operator"]
    	---

Authors: 
	Crashdome

Description:
    Used in Heirarchical Task Networks to encapsulate an action. Operators determine if
	an action can be completed and also apply effects to the context while planning.

Returns:
	<HashmapObject> of an Operator

---------------------------------------------------------------------------- */
[
	["#type","XPS_AP_typ_Operator"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Operator"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IOperator>, <XPS_AP_ifc_INode>
	-----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_AP_ifc_IOperator"]],
	/*----------------------------------------------------------------------------
	Protected: action
    
    	--- Prototype --- 
    	get "action"
    	---

	Description:
		The action this Operator ewxecutes when running.

    Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil

	-----------------------------------------------------------------------------*/
    ["action", nil],
    ["effects", {}],
	/*----------------------------------------------------------------------------
	Protected: precondition
    
    	--- Prototype --- 
    	call ["precondition",[_context, _args*]]
    	---

        Alternative: 

        --- code ---
        get "precondition"  //allows lazy execution
        ---

	Description:
		Conditional check to see if operator is a valid to plan for or run.
    
    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to precondition when executed

    Returns: 
		<Boolean> - True if satisfied, otherwise False

	-----------------------------------------------------------------------------*/
    ["precondition", {}],
	["Name","(unnamed)"],
	/*----------------------------------------------------------------------------
	Method: ApplyEffects
    
    	--- Prototype --- 
    	call ["ApplyEffects",[_context, _args*]]
    	---

        Alternative: 

        --- code ---
        get "Operation"  //allows lazy execution
        ---

		<XPS_AP_ifc_IOperator>

	Description:
		Code to execute to complete task.

    Parameters: 
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Optionals:
        _args* - (Optional) - <Anything> - arguments passed to Operation when executed

    Returns: 
		<Nothing>

	-----------------------------------------------------------------------------*/
    ["ApplyEffects", {
		params [["_context",createhashmap,[createhashmap]],"_args"];
		_context merge [_self call ["effects", _args],true];
	}],
    ["Evaluate", {
		_self call ["precondition", _this];
	}],
    ["Execute", {
		_self call ["action", _this];
	}]
]