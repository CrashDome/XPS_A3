#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_ActionSAsync
	<TypeDefinition>
	---prototype
	XPS_AP_typ_ActionSAsync : XPS_AP_ifc_Action
	---
	---prototype
	createhashmapobject [XPS_AP_typ_ActionSAsync, []]
	---

Authors: 
	CrashDome

Description:
	An asynchronous version of <XPS_AP_typ_Action> where the result 

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_ActionSAsync"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_ActionSAsync"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IAction>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IAction"]],
	["handle",nil],
	["callback",compileFinal {
		private _status = _this;
		_self call ["postTick",_status];
		_self set ["handle",nil];
	}],
	/*----------------------------------------------------------------------------
	Method: Halt
    
    	--- Prototype --- 
    	call ["Halt"]
    	---

	Description:
		Halts a script called asynchronously

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Halt",compileFinal {		
		_handle = _self get "handle";
		if !(isNil "_handle") then {
			terminate _handle;
			_self set ["handle",nil];
		};
		_self call ["postTick", XPS_Status_Failure];
	}],
	["Execute", {	
		if (isNil {_self get "handle"} && isNil {_self get "Status"}) then {	
			_self call ["preExecute",_this];	
				_handle = [_self,_this] spawn {
					params ["_action","_context"];
					private _status = _action call ["action",_context]; 
					_action call ["callback",_status]
				};
				_self set ["handle",_handle];
		};
		if (scriptDone (_self get "handle") && {_self get "Status" isEqualTo XPS_Status_Running}) then {
			_self call ["Halt"];
		};
		_self get "Status";
	}]
    
]