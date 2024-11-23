#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Elector
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Elector : XPS_BT_ifc_INode, XPS_BT_typ_Decorator
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Elector"]
    	---

Authors: 
	Crashdome

Description:
	A node that ticks it's child only if a condition is satisfied.

Returns:
	<HashmapObject> of a Decorator node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Elector"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_BT_typ_Decorator>
	-----------------------------------------------------------------------------*/
	["#base",XPS_BT_typ_Decorator],
	/*----------------------------------------------------------------------------
	Constructor: #create
		<XPS_BT_typ_Decorator. #create>
	-----------------------------------------------------------------------------*/
	["#create", {_self call ["XPS_BT_typ_Decorator.#create"];}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Elector"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_typ_Decorator. @interfaces>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Condition
    
    	--- Prototype --- 
    	call ["Condition",_context]
    	---

	Description:
		The code that executes during a Tick of this node and then
		returns true/false. 
		
		Must be Overridden.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface
		
	Returns: 
		<Boolean> - <True> or <False>
	-----------------------------------------------------------------------------*/
	["Condition",nil]
	/*----------------------------------------------------------------------------
	Property: NodeType
		<XPS_BT_typ_Decorator. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_Decorator. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<XPS_BT_typ_Decorator. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	call ["processTick",_context]
    	---

	Description:
		Ticks all children at once. Any failures results in "FAILURE"

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		if (_self call ["Condition",_this]) then {
			_self call ["XPS_BT_typ_Decorator.processTick",_this];
		} else {
			XPS_BT_Status_Failure;
		};
	}]
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_Decorator. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: AddChildNode
		<XPS_BT_typ_Decorator. AddChildNode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_Decorator. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Decorator. Tick>
	-----------------------------------------------------------------------------*/
]