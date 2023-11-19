#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Queue
	<TypeDefinition>
        --- prototype
        XPS_typ_Queue : XPS_ifc_IQueue
        ---
        --- prototype
        createhashmapobject [XPS_typ_Queue]
        ---

Authors: 
	Crashdome
   
Description:
	A First In First Out (FIFO) collection. 

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type", "XPS_typ_Queue"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---
    
    Return:
        True
    ----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Queue"
		---
	----------------------------------------------------------------------------*/
	["#str", {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IQueue>
		<XPS_ifc_IList>
	----------------------------------------------------------------------------*/
    ["@interfaces", ["XPS_ifc_IQueue"]],
	["_queueArray",[],[["CTOR"]]],
    /*----------------------------------------------------------------------------
    Method: Clear
    
        --- Prototype --- 
        call ["Clear"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
	["Clear",{
		_self get "_queueArray" resize 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Count
    
        --- Prototype --- 
        call ["Count"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		<Number> - the number of elements in the stack
    ----------------------------------------------------------------------------*/
	["Count",{
		count (_self get "_queueArray");
	}],
    /*----------------------------------------------------------------------------
    Method: IsEmpty
    
        --- Prototype --- 
        call ["IsEmpty"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		<Boolean> - True if queue is empty, otherwise False.
    ----------------------------------------------------------------------------*/
	["IsEmpty",{
		count (_self get "_queueArray") == 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Peek
    
        --- Prototype --- 
        call ["Peek"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		Anything - first element in the queue or nil if empty - does not remove 
		from queue
    ----------------------------------------------------------------------------*/
	["Peek",{
        if !(_self call ["IsEmpty"]) then {
		    _self get "_queueArray" select 0;
        } else {nil};
	}],
    /*----------------------------------------------------------------------------
    Method: Dequeue
    
        --- Prototype --- 
        call ["Dequeue"]
        ---

        <XPS_ifc_IStack>
    
    Parameters: 
		none
		
	Returns:
		Anything - removes and returns last element in the queue or nil if empty
    ----------------------------------------------------------------------------*/
	["Dequeue",{
        if !(_self call ["IsEmpty"]) then {
		    _self get "_queueArray" deleteat 0;
        } else {nil};
	}],
    /*----------------------------------------------------------------------------
    Method: Enqueue
    
        --- Prototype --- 
        call ["Enqueue",_value]
        ---

        <XPS_ifc_IStack>
    
    Parameters: 
		_value - the value to push to top of the queue
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
	["Enqueue",{
		_self get "_queueArray" pushback _this;
	}]
]