#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_HTNDomain
	<TypeDefinition>
	---prototype
	XPS_AP_typ_HTNDomain : XPS_AP_ifc_HTNDomain
	---
	---prototype
	createhashmapobject [XPS_AP_typ_HTNDomain, [_name]]
	---

Authors: 
	CrashDome

Description:
	A collection of HTN <action_planning.XPS_AP_ifc_INodes> to pass into a planner. These include but,
	may not be limited to: 
		- <XPS_AP_typ_Operator>
		- <XPS_AP_typ_PrimitiveTask>
		- <XPS_AP_typ_CompoundTask>

Paramters: 
	_name - <String> - Name of the domain

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_HTNDomain"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_name, _allowedTypes*]]
    	---
    
    Paramters: 
        _name - <String> - Name of the domain

    Optionals: 
        _allowedTypes* - <Array> - (Optional : Default ["XPS_AP_typ_Operator","XPS_AP_typ_PrimitiveTask","XPS_AP_typ_CompoundTask"]) - array of <Strings> of predetermined types 

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params [["_name",nil,[""]]];
		if !(isNil "_name") then {_self set ["Name",_name]};
        _self set ["_nodes", createhashmapobject ["XPS_typ_TypeCollection",[createhashmapfromarray ["XPS_typ_HashmapObjectTypeRestrictor",["XPS_AP_typ_Operator","XPS_AP_typ_PrimitiveTask","XPS_AP_typ_CompoundTask"]]]]];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_HTNDomain"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {(_self get "#type" select 0) + " : " + (_self get "Name")}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IDomain>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IDomain"]],
    //["#create"]
    ["_nodes",createhashmap],

	["Name","(unnamed)"],
    ["AddNode",{
        if !(params [["_node",[],[[],createhashmap]]]) exitwith {false;};
        
		if !(_node isEqualType []) then {
			_node = [_node];
		};

		{ 
			_self get "_nodes"  call ["AddItem",[_x get "Name", _x]];
		} foreach _node;
    }],
    ["GetNode",{
		_self get "_nodes" call ["GetItem", _key];
	}]
]