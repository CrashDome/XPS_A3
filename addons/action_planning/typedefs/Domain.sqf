#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_Domain
	<TypeDefinition>
	---prototype
	XPS_AP_typ_Domain : XPS_AP_ifc_IDomain
	---
	---prototype
	createhashmapobject [XPS_AP_typ_Domain, [_name]]
	---

Authors: 
	CrashDome

Description:
	A collection of <XPS_AP_ifc_INodes> to pass into a planner. 

Paramters: 
	_name - <String> - Name of the domain

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_Domain"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_name, _allowedTypes*]]
    	---
    
    Paramters: 
        _name - <String> - Name of the domain

    Optionals: 
        _allowedTypes* - <Array> - (Optional : Default ["XPS_AP_ifc_INodes"]) - array of <Strings> of predetermined types 

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params [["_name","(unnamed)",[""]],["_allowedTypes",["XPS_AP_ifc_INode"],[[]]]];
		if !(isNil "_name") then {_self set ["Name",_name]};
        _self set ["_nodes", createhashmapobject ["XPS_typ_TypeCollection",[createhashmapfromarray ["XPS_typ_HashmapObjectTypeRestrictor",_allowedTypes]]]];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Domain:Name"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {(_self get "#type" select 0) + " : " + (_self get "Name")}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IDomain>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IDomain"]],
    ["_nodes",createhashmap],
	/*----------------------------------------------------------------------------
	Property: Name
    
    	--- Prototype --- 
    	get "Name"
    	---

		<XPS_AP_ifc_IDomain>
    
    Returns: 
		<String> - the name or identifier of the domain
	-----------------------------------------------------------------------------*/
	["Name","(unnamed)"],
    	/*----------------------------------------------------------------------------
	Method: AddNode
    
    	--- Prototype --- 
    	call ["AddNode", _nodes]
    	---

		<XPS_AP_ifc_IDomain>

	Description:
		Adds a single or list of <XPSAP_ifc_INodes>, if allowed, to the domain

	Parameters:
		_nodes - <XPS_AP_ifc_INode> or <Array> of nodes

	Returns: 
		<Nothing>
	-----------------------------------------------------------------------------*/
    ["AddNode",{
        if !(params [["_node",[],[[],createhashmap]]]) exitwith {false;};
        
		if !(_node isEqualType []) then {
			_node = [_node];
		};

		{ 
			_self get "_nodes"  call ["AddItem",[_x get "Name", _x]];
		} foreach _node;
    }],
    /*----------------------------------------------------------------------------
	Method: GetNode
    
    	--- Prototype --- 
    	call ["GetNode", _name]
    	---

		<XPS_AP_ifc_IDomain>

	Parameters:
		_name - <String> - the name/key to lookup

	Returns: 
		<XPS_AP_ifc_INode> - if found otherwise nil
	-----------------------------------------------------------------------------*/
    ["GetNode",{
		_self get "_nodes" call ["GetItem", _key];
	}]
]