#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_HTNDomain
	<TypeDefinition>
	---prototype
	XPS_AP_typ_HTNDomain : XPS_AP_ifc_IDomain, XPS_AP_typ_Domain
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
	Parent: #base
    	<XPS_AP_typ_Domain>
	-----------------------------------------------------------------------------*/
	["#base", XPS_AP_typ_Domain],
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
		params [["_name","(unnamed)",[""]],["_allowedTypes",["XPS_AP_typ_Operator","XPS_AP_typ_PrimitiveTask","XPS_AP_typ_CompoundTask"],[[]]]];
		_self call ["XPS_typ_Domain.#create", [_name,_allowedTypes]];
	}]
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_HTNDomain:Name"
    	---
		
    	<XPS_AP_typ_Domain>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Name
    
    	--- Prototype --- 
    	get "Name"
    	---

		<XPS_AP_typ_Domain.Name>
	-----------------------------------------------------------------------------*/
    	/*----------------------------------------------------------------------------
	Method: AddNode
    
    	--- Prototype --- 
    	call ["AddNode", _nodes]
    	---

		<XPS_AP_typ_Domain.AddNode>
	-----------------------------------------------------------------------------*/

    /*----------------------------------------------------------------------------
	Method: GetNode
    
    	--- Prototype --- 
    	call ["GetNode", _name]
    	---

		<XPS_AP_typ_Domain.GetNode>
	-----------------------------------------------------------------------------*/
]