#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_ActionUAsync
	<TypeDefinition>
	---prototype
	XPS_AP_typ_ActionUAsync : XPS_AP_ifc_Action
	---
	---prototype
	createhashmapobject [XPS_AP_typ_ActionUAsync, []]
	---

Authors: 
	CrashDome

Description:
	(Description)

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_ActionUAsync"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_ActionUAsync"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IAction>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IAction"]],
	["_startTime",-1],
	/*----------------------------------------------------------------------------
	Protected: condition
    
    	--- Prototype --- 
    	call ["condition",_context]
    	---

	Description:
		The code that executes during a Tick of this node when processTick has already been called

	Must be Overridden - This type contains no functionality

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Boolean> - condition was ssatified
	-----------------------------------------------------------------------------*/
	["condition", compileFinal {true}],
	["timeout",0],
	/*----------------------------------------------------------------------------
	Method: Halt
    
    	--- Prototype --- 
    	call ["Halt"]
    	---

	Description:
		Halts any asynchronous call by invoking a failure and setting <starttime> to 0

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Halt",compileFinal {		
		_self call ["postExecute", XPS_Status_Failure];
	}],
	["Execute", {	
		switch (true) do {

			case (isNil {_self get "Status"}): {
				_self call ["preExecute",_this];
				_self call ["action",_this];
			};
			case (_self get "timeout" > 0 && {diag_tickTime > ((_self get "timeout") + (_self get "_startTime"))}): {
				_self call ["Halt"];
			};
			case (_self call ["condition",_this]): {
				_self call ["postExecute",XPS_Status_Success];
			};
		};
	}]    
]